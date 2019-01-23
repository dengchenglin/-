//
//  CTSearchService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchService.h"

#import "CTSearchViewController.h"

@implementation CTSearchService

CL_EXPORT_MODULE(CTSearchServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTSearchViewController new];
}

@end
