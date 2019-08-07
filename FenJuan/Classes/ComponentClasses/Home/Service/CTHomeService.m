//
//  CTHomeService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeService.h"

#import "CTHomePageController.h"

@implementation CTHomeService

CL_EXPORT_MODULE(CTHomeServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTHomePageController new];
}

@end
