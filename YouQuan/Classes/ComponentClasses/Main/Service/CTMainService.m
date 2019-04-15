//
//  CTMainService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMainService.h"

#import "CTMainController.h"

@implementation CTMainService

CL_EXPORT_MODULE(CTMainServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTMainController new];
}

@end
