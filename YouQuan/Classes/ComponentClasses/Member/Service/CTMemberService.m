//
//  CTMemberService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMemberService.h"

#import "CTMemberViewController.h"

@implementation CTMemberService

CL_EXPORT_MODULE(CTMemberServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTMemberViewController new];
}

@end
