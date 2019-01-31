//
//  CTAlertHelper+WithdrawSuccess.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlertHelper.h"

@interface CTAlertHelper (WithdrawSuccess)

+ (void)showWithdrawSuccessViewWithCallback:(void(^)(NSUInteger buttonIndex))callback;

@end
