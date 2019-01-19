//
//  CTSearchTicketService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchTicketService.h"

#import "CTSearchTicketViewController.h"

@implementation CTSearchTicketService

CL_EXPORT_MODULE(CTSearchTicketServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTSearchTicketViewController new];
}

@end
