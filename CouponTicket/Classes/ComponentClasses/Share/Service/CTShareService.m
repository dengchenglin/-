//
//  CTShareService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTShareService.h"

#import "CTShareViewController.h"

@implementation CTShareService

CL_EXPORT_MODULE(CTShareServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTShareViewController new];
}

@end
