//
//  MBProgressHUD+Helper.h
//  YMKMain
//
//  Created by dengchenglin on 2018/7/3.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Helper)

+ (void)showMBProgressHudOnView:(UIView *)view;

+ (void)showMBProgressHudWithTitle:(NSString *)title top:(CGFloat)top;

+ (void)showMBProgressHudWithTitle:(NSString *)title;

+ (void)showMBProgressHudOnView:(UIView *)view title:(NSString *)title;

+ (void)showMBProgressHudOnView:(UIView *)view hideAfterDelay:(NSTimeInterval)hideAfterDelay;

+ (void)showMBProgressHudWithTitle:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay;

+ (void)showMBProgressHudOnView:(UIView *)view title:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay;

+ (void)showMBProgressHudWithTitle:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay complited:(void(^)(void))complited;

@end
