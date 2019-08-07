//
//  CLRefreshCurveFooter.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshCurveFooter.h"

#import "CLRefreshCurveLayer.h"

#import "CLRefreshNulMoreView.h"


#define kRefreshUpString     @"上拉加载更多..."

#define kReleaseString       @"松开加载更多..."

#define kLoadingMoreString   @"正在加载更多..."


@interface CLRefreshCurveFooter ()

@property (nonatomic,strong)CLRefreshNulMoreView *nulMoreView;

@end

@implementation CLRefreshCurveFooter
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

- (CLRefreshNulMoreView *)nulMoreView{
    if(!_nulMoreView){
        _nulMoreView = [[CLRefreshNulMoreView alloc]init];
        [self addSubview:_nulMoreView];
    }
    return _nulMoreView;
}

- (void)setUp{
    
    _curveLayer = [CLRefreshCurveLayer layer];
    [self.layer addSublayer:_curveLayer];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = kRefreshUpString;
    _titleLabel.font = [UIFont systemFontOfSize:14 ];
    _titleLabel.textColor = [UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_titleLabel];
    
    self.alpha = 0.3;
}

- (CGFloat)originalHeight{
    return 60;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _curveLayer.bounds = CGRectMake(0, 0, 26, 26);
    _curveLayer.position = CGPointMake(self.bounds.size.width/2 - 35, self.bounds.size.height/2);
    [_titleLabel setFrame:CGRectMake(CGRectGetMaxX(_curveLayer.frame) + 10, 0, 150, self.bounds.size.height)];
    [_nulMoreView setFrame:self.bounds];
}


- (void)setProgress:(CGFloat)progress{
    [super setProgress:progress];

    _curveLayer.progress = progress;
    self.alpha = 0.3 +  progress * 0.7;
    if(progress < 1.0){
        _titleLabel.text = kRefreshUpString;
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
        _titleLabel.text = kLoadingMoreString;
    }

}

- (void)setDiff:(CGFloat)diff{
    [super setDiff:diff];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _curveLayer.affineTransform = CGAffineTransformMakeRotation(M_PI * ((diff + 10)*2/180));
    [CATransaction commit];

}

- (void)showNulMoreView{
    [super showNulMoreView];
    self.nulMoreView.hidden = NO;
    _curveLayer.hidden = YES;
    _titleLabel.hidden = YES;
}

- (void)hiddenNulMoreView{
    [super hiddenNulMoreView];
    self.nulMoreView.hidden = YES;
    _curveLayer.hidden = NO;
    _titleLabel.hidden = NO;
}

@end
