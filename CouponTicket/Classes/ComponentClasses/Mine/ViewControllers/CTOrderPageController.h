//
//  CTOrderPageController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPageController.h"

typedef NS_ENUM(NSInteger,CTOrderStatus) {
    CTOrderAll = 0,
    CTOrderPayed,
    CTOrderRebated,
    CTOrderLose,
    CTOrderRefund
};

@interface CTOrderPageController : CTPageController

@end
