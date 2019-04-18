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
#import "CTRegisterViewController.h"

@implementation CTLoginService

CL_EXPORT_MODULE(CTLoginServiceProtocol)

- (Class)rootBaseClass{
    return CTLoginBaseViewController.class;
}

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

- (void)judgeLoginWithViewController:(UIViewController *)viewController completed:(void(^)(void))completed{
    if([CTAppManager logined]){
        if(completed){
            completed();
        }
    }
    else {
        [[CTModuleManager loginService]showLoginFromViewController:viewController callback:^(BOOL logined) {
            if(logined){
                if(completed){
                    completed();
                }
            }
        }];
    }
}


- (void)showRegisterFromViewController:(UIViewController *)viewController  inviteCode:(NSString *)inviteCode callback:(void(^)(BOOL logined))callback{
    CTRegisterViewController *vc = [CTRegisterViewController new];
    vc.eventKind = CTEventKindRegister;
    vc.inviteCode = inviteCode;
    if([viewController isKindOfClass:CTLoginBaseViewController.class]){
        [viewController.navigationController pushViewController:vc animated:YES];
    }
    else{
        CTNavigationController *nav = [[CTNavigationController alloc]initWithRootViewController:vc];
        [viewController presentViewController:nav animated:YES completion:nil];
        
        __weak UIViewController *weakVc = vc;
        [vc setCompleted:^{
            [weakVc dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}
@end
