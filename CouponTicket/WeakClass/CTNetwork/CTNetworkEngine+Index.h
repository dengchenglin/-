//
//  CTNetworkEngine+Index.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTNetworkEngine (Index)

//首页数据
- (CLRequest *)indexWithCallback:(CTResponseBlock)callback;

@end
