//
//  CTMineService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMineService.h"

#import "CTMineViewController.h"

@implementation CTMineService

CL_EXPORT_MODULE(CTMineServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTMineViewController new];
}

@end
