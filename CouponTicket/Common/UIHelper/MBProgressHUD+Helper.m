//
//  MBProgressHUD+Helper.m
//  YMKMain
//
//  Created by dengchenglin on 2018/7/3.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "MBProgressHUD+Helper.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "NSTimer+YYAdd.h"

@implementation MBProgressHUD (Helper)


+ (void)showMBProgressHudOnView:(UIView *)view{
    if(!view)return;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    [hud showAnimated:YES];

}

+ (void)showMBProgressHudWithTitle:(NSString *)title top:(CGFloat)top{
    [self showMBProgressHudOnView:nil top:top title:title hideAfterDelay:1.0];
}

+ (void)showMBProgressHudWithTitle:(NSString *)title{
    [self showMBProgressHudOnView:nil top:0 title:title hideAfterDelay:1.0];
}

+ (void)showMBProgressHudOnView:(UIView *)view title:(NSString *)title{
    [self showMBProgressHudOnView:view top:0 title:title hideAfterDelay:1.0];
}

+ (void)showMBProgressHudWithTitle:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay{
    [self showMBProgressHudOnView:nil top:0 title:title hideAfterDelay:hideAfterDelay];

}


+ (void)showMBProgressHudWithTitle:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay complited:(void(^)(void))complited{
    [self showMBProgressHudOnView:nil top:0 title:title  hideAfterDelay:hideAfterDelay];
    [NSTimer scheduledTimerWithTimeInterval:hideAfterDelay block:^(NSTimer *timer) {
        if(complited){
            complited();
        }
    } repeats:NO];
}

+ (void)showMBProgressHudOnView:(UIView *)view top:(CGFloat)top title:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay{
    if(!title.length)return;
    if(!view){
        view = [UIApplication sharedApplication].keyWindow;
    }
 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    if(top >= 0){
        hud.detailsLabel.top = top;
    }
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.detailsLabel.text = title;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:hideAfterDelay];

}


@end
