//
//  CTWithdrawInputPsdView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlertView.h"

@interface CTWithdrawInputPsdView : CTAlertView

@property (nonatomic, copy) void (^callback)(NSString *password);

@end
