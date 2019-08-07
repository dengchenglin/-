//
//  CTAlertHelper+WithdrawSuccess.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlertHelper+WithdrawSuccess.h"

#import "CTWithdrawSuccessView.h"

@implementation CTAlertHelper (WithdrawSuccess)

+ (void)showWithdrawSuccessViewWithCallback:(void(^)(NSUInteger buttonIndex))callback{
    CTWithdrawSuccessView *alertView = NSMainBundleClass(CTWithdrawSuccessView.class);
    [self showAlertView:alertView callback:callback];
}

@end
