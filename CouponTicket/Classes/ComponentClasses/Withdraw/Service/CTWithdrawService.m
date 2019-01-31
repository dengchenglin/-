//
//  CTWithdrawService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWithdrawService.h"

#import "CTWithdrawViewController.h"

@implementation CTWithdrawService

CL_EXPORT_MODULE(CTWithdrawServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTWithdrawViewController new];
}

@end
