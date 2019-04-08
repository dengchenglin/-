//
//  CTUserInfoService.m
//  CouponTicket
//
//  Created by Dankal on 2019/2/14.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTUserInfoService.h"
#import "CTUserDetailViewController.h"
#import "CTUserEditViewController.h"
@implementation CTUserInfoService

CL_EXPORT_MODULE(CTUserInfoServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTUserDetailViewController new];
}

- (UIViewController *)viewControllerForUserId:(NSString *)userId{
    CTUserDetailViewController *vc = [CTUserDetailViewController new];
    vc.userId = userId;
    return vc;
}

- (UIViewController *)viewControllerForType:(CTUserEditType)type{
    CTUserEditViewController *vc = [CTUserEditViewController new];
    vc.type = type;
    return vc;
}

@end
