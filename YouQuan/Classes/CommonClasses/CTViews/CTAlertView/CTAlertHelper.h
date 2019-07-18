//
//  CTAlertHelper.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTAlertView.h"

@interface CTAlertHelper : NSObject

+ (void)showAlertView:(CTAlertView *)alertView callback:(void(^)(NSUInteger buttonIndex))callback;

+ (void)showAlertView:(CTAlertView *)alertView onView:(UIView *)view callback:(void(^)(NSUInteger buttonIndex))callback;

+ (void)showNoticeAlertViewWithTitle:(NSString *)title;

+ (void)showNoticeAlertViewWithTitle:(NSString *)title callback:(void(^)(NSUInteger buttonIndex))callback;

+ (void)showTbauthAlertViewWithCallback:(void(^)(NSUInteger buttonIndex))callback;

+ (void)showTbauthFailAlertViewWithTitle:(NSString *)title callback:(void(^)(NSUInteger buttonIndex))callback;

//升级说明
+ (void)showUpgradePopViewWithInfoConfig:(void(^)(NSString **text1,NSString **text2,NSString **text3))infoConfig;

+ (void)hideAlertView;
@end
