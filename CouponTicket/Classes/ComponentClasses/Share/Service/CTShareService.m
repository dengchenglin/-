//
//  CTShareService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTShareService.h"

#import "CTShareViewController.h"

@implementation CTShareService

CL_EXPORT_MODULE(CTShareServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTShareViewController new];
}

- (UIViewController *)pushShareFromViewController:(UIViewController *)viewController{
    CTShareViewController *vc = [CTShareViewController new];
    if([CTAppManager logined]){
        [viewController.navigationController pushViewController:vc animated:YES];
    }
    else{
        [[CTModuleManager loginService] showLoginFromViewController:viewController success:^{
            [viewController.navigationController pushViewController:vc animated:YES];
        } failure:nil];
    }
    return vc;
}
@end
