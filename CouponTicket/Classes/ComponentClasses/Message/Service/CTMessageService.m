//
//  CTMessageService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMessageService.h"

#import "CTMessageViewController.h"

@implementation CTMessageService

CL_EXPORT_MODULE(CTMessageServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTMessageViewController new];
}

@end
