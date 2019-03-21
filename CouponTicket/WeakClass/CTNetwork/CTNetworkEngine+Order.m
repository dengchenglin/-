//
//  CTNetworkEngine+Order.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Order.h"

#define CTOrder(path)   [CTUrlPath(@"order") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Order)

- (CLRequest *)orderIndexWithPage:(NSInteger)page size:(NSInteger)size tkStatus:(CTOrderStatus)status callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:status?@(status):nil forKey:@"tk_status"];
    return [self postWithPath:CTOrder(@"index") params:params callback:callback];
}

@end
