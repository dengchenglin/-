//
//  CTMessageService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMessageService.h"

#import "FJMessageViewControllerfj.h"

@implementation CTMessageService

CL_EXPORT_MODULE(CTMessageServiceProtocol)

- (UIViewController *)rootViewController{
    return [FJMessageViewControllerfj new];
}


- (UIViewController *)pushMessageFromViewController:(UIViewController *)viewController{
    FJMessageViewControllerfj *vc = [FJMessageViewControllerfj new];
    if([CTAppManager logined]){
        [viewController.navigationController pushViewController:vc animated:YES];
    }
    else{
        [[CTModuleManager loginService] fj_showLoginFromViewController:viewController success:^{
            [viewController.navigationController pushViewController:vc animated:YES];
        } failure:nil];
    }
    return vc;
}
@end
