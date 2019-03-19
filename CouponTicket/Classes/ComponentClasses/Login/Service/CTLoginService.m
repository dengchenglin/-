//
//  CTLoginService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginService.h"

#import "CTLoginViewController.h"

#import "CTGetCodeViewController.h"

#import "CTAlipayBoundViewController.h"

@implementation CTLoginService

CL_EXPORT_MODULE(CTLoginServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTLoginViewController new];
}

- (void)showLoginFromViewController:(UIViewController *)viewController success:(void(^)(void))success failure:(void(^)(void))failure{
    [CTLoginViewController showLoginFormViewController:viewController callback:^(BOOL logined) {
        if(logined){
            if(success)success();
        }
        else{
            if(failure)failure();
        }
    }];
}

- (void)showLoginFromViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback{
    [CTLoginViewController showLoginFormViewController:viewController callback:callback];
}

- (void)pushWithdrawSetpsdFromViewController:(UIViewController *)viewController mobile:(NSString *)mobile completed:(void(^)(void))completed{
    CTGetCodeViewController *vc = [CTGetCodeViewController new];
    vc.eventKind = CTEventKindWithDraw;
    vc.completed = completed;
    vc.mobile = mobile;
    [viewController.navigationController pushViewController:vc animated:YES];
}

- (void)pushBoundAlipayFromViewController:(UIViewController *)viewController completed:(void(^)(void))completed{
    CTAlipayBoundViewController *vc = [CTAlipayBoundViewController new];
    vc.completed = completed;
    [viewController.navigationController pushViewController:vc animated:YES];
}


@end
