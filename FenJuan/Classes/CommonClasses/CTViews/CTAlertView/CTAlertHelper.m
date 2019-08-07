//
//  CTAlertHelper.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlertHelper.h"
#import <objc/runtime.h>
#import "CTNoticeAlertView.h"
#import "CTTbAuthAlertView.h"
#import "CTTbAuthFailAlertView.h"
#import "CTUpgradePopView.h"

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

+ (void)showNoticeAlertViewWithTitle:(NSString *)title{
    [self showNoticeAlertViewWithTitle:title callback:nil];
}

+ (void)showNoticeAlertViewWithTitle:(NSString *)title callback:(void(^)(NSUInteger buttonIndex))callback{
    CTNoticeAlertView *alertView = NSMainBundleClass(CTNoticeAlertView.class);
    alertView.titleLabel.text = title;
    [self showAlertView:alertView onView:[UIApplication sharedApplication].keyWindow callback:callback];
}

+ (void)showTbauthAlertViewWithCallback:(void(^)(NSUInteger buttonIndex))callback{
    CTTbAuthAlertView *alertView = NSMainBundleClass(CTTbAuthAlertView.class);
    [self showAlertView:alertView callback:callback];
}
+ (void)showTbauthFailAlertViewWithTitle:(NSString *)title callback:(void(^)(NSUInteger buttonIndex))callback{
    CTTbAuthFailAlertView *alertView = NSMainBundleClass(CTTbAuthFailAlertView.class);
    alertView.titleLabel.text = title;
    [self showAlertView:alertView callback:callback];
}


+ (void)showUpgradePopViewWithInfoConfig:(void(^)(NSString **text1,NSString **text2,NSString **text3))infoConfig{
    NSString *txt1;
    NSString *txt2;
    NSString *txt3;
    if(infoConfig){
        infoConfig(&txt1,&txt2,&txt3);
    }
    CTUpgradePopView *alertView = NSMainBundleClass(CTUpgradePopView.class);
    alertView.label1.text = txt1;
    alertView.label2.text = txt2;
    alertView.label3.text = txt3;
    [self showAlertView:alertView callback:nil];
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
    __weak UIView *weakBackground = background;
    [alertView setCloseBlock:^{
        [weakBackground removeFromSuperview];
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
        objc_setAssociatedObject(view, &CTAlertViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
