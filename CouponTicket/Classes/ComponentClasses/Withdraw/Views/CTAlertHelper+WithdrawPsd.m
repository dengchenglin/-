//
//  CTAlertHelper+WithdrawPsd.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlertHelper+WithdrawPsd.h"

#import "CTWithdrawInputPsdView.h"

@implementation CTAlertHelper (WithdrawPsd)

+ (void)showPayPasswordViewWithCallback:(void(^)(NSString *password))callback{
    CTWithdrawInputPsdView *alertView = NSMainBundleClass(CTWithdrawInputPsdView.class);
    [alertView setCallback:^(NSString *password) {
        if(callback){
            callback(password);
        }
        [self hideAlertView];
    }];
    [self showAlertView:alertView callback:nil];
}

@end
