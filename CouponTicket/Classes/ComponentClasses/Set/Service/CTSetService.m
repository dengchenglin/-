//
//  CTSetService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSetService.h"

#import "CTSetViewController.h"

@implementation CTSetService

CL_EXPORT_MODULE(CTSetServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTSetViewController new];
}

@end
