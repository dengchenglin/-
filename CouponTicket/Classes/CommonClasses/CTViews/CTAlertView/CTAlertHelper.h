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

+ (void)hideAlertView;
@end
