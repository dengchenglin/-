//
//  CTNetworkEngine+Index.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Index.h"

#define CTIndex(path)   [CTUrlPath(@"index") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Index)

- (CLRequest *)indexWithCallback:(CTResponseBlock)callback{
     return [self postWithPath:CTIndex(@"index") params:nil callback:callback];
}

@end
