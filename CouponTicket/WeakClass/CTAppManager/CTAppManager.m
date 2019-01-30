//
//  CTAppManager.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAppManager.h"

@implementation CTUser

@end

@implementation CTAppManager

SINGLETON_FOR_CLASS_IMP(CTAppManager)

+ (BOOL)logined{
    return YES;//[CTAppManager sharedInstance].user;
}

@end
