//
//  CTToolService.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/30.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTToolService.h"

#import "CTQuestionViewController.h"

@implementation CTToolService

CL_EXPORT_MODULE(CTToolServiceProtocol)

- (UIViewController *)questionViewController{
    return [CTQuestionViewController new];
}

@end
