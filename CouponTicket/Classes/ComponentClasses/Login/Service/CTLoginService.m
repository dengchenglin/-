//
//  CTLoginService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginService.h"

#import "CTLoginViewController.h"

@implementation CTLoginService

CL_EXPORT_MODULE(CTLoginServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTLoginViewController new];
}

- (void)showLoginFormViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback{
    [CTLoginViewController showLoginFormViewController:viewController callback:callback];
}


@end
