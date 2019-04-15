//
//  CTRecommendService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTRecommendService.h"

#import "CTRecommendViewController.h"

@implementation CTRecommendService

CL_EXPORT_MODULE(CTRecommendServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTRecommendViewController new];
}

@end
