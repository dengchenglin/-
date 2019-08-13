//
//  CTNetworkEngine+Order.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"
typedef NS_ENUM(NSInteger,CTOrderStatus){
    CTOrderAll = 0,
    CTOrderAccounted = 3,     //已结算
    CTOrderPayed = 12,        //已付款
    CTOrderLose = 13,         //订单失效
    CTOrderSuccess = 14,      //订单成功
};

@interface CTNetworkEngine (Order)

- (CLRequest *)fj_orderIndexWithPage:(NSInteger)page size:(NSInteger)size tkStatus:(CTOrderStatus)status callback:(CTResponseBlock)callback;

@end
