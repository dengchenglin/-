//
//  CLRefreshCurveView.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshCurveHeader.h"

#import "CLRefreshCurveLayer.h"

#define kRefreshDownString   @"下拉即可刷新..."
#define kReleaseString       @"松开即可刷新..."
#define kRefreshString       @"正在刷新..."


@implementation CLRefreshCurveHeader
{
    CLRefreshCurveLayer*_curveLayer;
    UILabel *_titleLabel;
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView{
    if(self = [super initWithScrollView:scrollView]){
        [self setUp];
    }
    return self;
}

- (void)setUp{
   
    _curveLayer = [CLRefreshCurveLayer layer];

    [self.layer addSublayer:_curveLayer];
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = kRefreshDownString;
    _titleLabel.font = [UIFont systemFontOfSize:14 ];
    _titleLabel.textColor = [UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_titleLabel];
    
    self.alpha = 0.3;
}

- (void)layoutSubviews{
    [super layoutSubviews];
     [self setFrame:CGRectMake(0, -60, self.scrollView.bounds.size.width - self.scrollView.contentInset.left - self.scrollView.contentInset.right, 60)];
    _curveLayer.bounds = CGRectMake(0, 0, 26, 26);
    _curveLayer.position = CGPointMake(self.bounds.size.width/2 - 35, self.bounds.size.height/2);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_curveLayer.frame) + 10, 0, 150, self.bounds.size.height);
}


- (void)setProgress:(CGFloat)progress{
    [super setProgress:progress];
    _curveLayer.progress = progress;
    self.alpha = 0.3 +  progress * 0.7;
    if(progress < 1.0){
        _titleLabel.text = kRefreshDownString;
    }
    else{
        _titleLabel.text = kReleaseString;
    }

}

- (void)setLoading:(BOOL)loading{
    [super setLoading:loading];
    if(loading){
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        _curveLayer.affineTransform = CGAffineTransformIdentity;
        [CATransaction commit];
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = @(M_PI * 2.0);
        rotationAnimation.duration = 0.5f;
        rotationAnimation.autoreverses = NO;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.repeatCount = HUGE_VALF;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [_curveLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
    else{
        [_curveLayer removeAllAnimations];
    }
    
    if(loading){
        _titleLabel.text = kRefreshString;
    }

}

- (void)setDiff:(CGFloat)diff{
    [super setDiff:diff];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _curveLayer.affineTransform = CGAffineTransformMakeRotation(M_PI * ((diff + 10)*2/180));
    [CATransaction commit];

}

@end
