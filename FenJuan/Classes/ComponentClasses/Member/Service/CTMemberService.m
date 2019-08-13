//
//  CTMemberService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMemberService.h"

#import "FJMemberViewControllerfj.h"

#import "FJMemberEquityControllerfj.h"

@implementation CTMemberService

CL_EXPORT_MODULE(CTMemberServiceProtocol)

- (UIViewController *)rootViewController{
    return [FJMemberViewControllerfj new];
}
- (UIViewController *)memberEquityViewController{
    return [FJMemberEquityControllerfj new];
}
@end
