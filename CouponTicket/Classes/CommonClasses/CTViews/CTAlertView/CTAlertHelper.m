//
//  CTAlertHelper.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlertHelper.h"

#import <objc/runtime.h>

static const int CTAlertViewKey;


@interface CTAlertBackground : UIView

@property (nonatomic, strong) UIImageView *backgroundView;

@end

@implementation CTAlertBackground

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backgroundView = [[UIImageView alloc]init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0;
        _backgroundView.userInteractionEnabled = YES;
        [self addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        @weakify(self)
        [_backgroundView addActionWithBlock:^(id target) {
            @strongify(self);
            [self removeFromSuperview];
        }];
    }
    return self;
}

@end

@implementation CTAlertHelper

+ (void)showAlertView:(CTAlertView *)alertView callback:(void(^)(NSUInteger buttonIndex))callback{
     [self showAlertView:alertView onView:[UIApplication sharedApplication].keyWindow callback:callback];
}

+ (void)showAlertView:(CTAlertView *)alertView onView:(UIView *)view callback:(void(^)(NSUInteger buttonIndex))callback{
    if(!view || !alertView){
        return;
    }
    if(callback){
        [alertView setCallback:^(NSUInteger buttonIndex) {
            [self hideAlertView];
            callback(buttonIndex);
        }];
    }
    
    [self hideAlertView];
    CTAlertBackground *background = [[CTAlertBackground alloc]init];
    [background addSubview:alertView];
    [view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(background.mas_centerX);
        make.centerY.mas_equalTo(background.mas_centerY);
        make.width.mas_equalTo(280);
    }];
    [alertView setCloseBlock:^{
        [background removeFromSuperview];
    }];
    objc_setAssociatedObject([UIApplication sharedApplication].keyWindow, &CTAlertViewKey, background, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    //Animation
    background.backgroundView.alpha = 0;
    alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:5 initialSpringVelocity:30 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        background.backgroundView.alpha = 0.6;
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}


+ (void)hideAlertView{
    [self hideAlertOnView:[UIApplication sharedApplication].keyWindow];
}

+ (void)hideAlertOnView:(UIView *)view{
    if(!view)return;
    CTAlertBackground *alertBackground = objc_getAssociatedObject(view, &CTAlertViewKey);
    if(alertBackground){
        [alertBackground removeFromSuperview];
    }
}

@end
