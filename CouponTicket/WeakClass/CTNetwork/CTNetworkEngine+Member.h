//
//  CTNetworkEngine+Member.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTNetworkEngine (Member)

//会员信息
- (CLRequest *)userIndexWithCallback:(CTResponseBlock)callback;

@end
