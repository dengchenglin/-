//
//  CTNetworkEngine+Mine.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Mine.h"

@implementation CTNetworkEngine (Mine)

//获取我的邀请码
- (NSString *)qCodeUrl{
    NSString *path = [NSString stringWithFormat:@"api/user/user_qr.html?token=%@",[CTAppManager sharedInstance].token];
    return CTBaseUrl(path);
}

@end
