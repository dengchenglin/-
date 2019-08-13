//
//  CTLoginService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginService.h"

#import "FJLoginViewControllerfj.h"
#import "FJGetCodeViewControllerfj.h"
#import "FJAlipayBoundViewControllerfj.h"
#import "FJRegisterViewControllerfj.h"

@implementation CTLoginService

CL_EXPORT_MODULE(CTLoginServiceProtocol)

- (Class)rootBaseClass{
    return CTLoginBaseViewController.class;
}

- (UIViewController *)rootViewController{
    return [FJLoginViewControllerfj new];
}

- (void)fj_showLoginFromViewController:(UIViewController *)viewController success:(void(^)(void))success failure:(void(^)(void))failure{
    [FJLoginViewControllerfj showLoginFormViewController:viewController callback:^(BOOL logined) {
        if(logined){
            if(success)success();
        }
        else{
            if(failure)failure();
        }
    }];
}

- (void)fj_showLoginFromViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback{
    [FJLoginViewControllerfj showLoginFormViewController:viewController callback:callback];
}

- (void)fj_pushWithdrawSetpsdFromViewController:(UIViewController *)viewController mobile:(NSString *)mobile completed:(void(^)(void))completed{
    FJGetCodeViewControllerfj *vc = [FJGetCodeViewControllerfj new];
    vc.eventKind = CTEventKindWithDraw;
    vc.completed = completed;
    vc.mobile = mobile;
    [viewController.navigationController pushViewController:vc animated:YES];
}

- (void)fj_pushBoundAlipayFromViewController:(UIViewController *)viewController completed:(void(^)(void))completed{
    FJAlipayBoundViewControllerfj *vc = [FJAlipayBoundViewControllerfj new];
    vc.completed = completed;
    [viewController.navigationController pushViewController:vc animated:YES];
}

- (void)fj_judgeLoginWithViewController:(UIViewController *)viewController completed:(void(^)(void))completed{
    if([CTAppManager logined]){
        if(completed){
            completed();
        }
    }
    else {
        [[CTModuleManager loginService]fj_showLoginFromViewController:viewController callback:^(BOOL logined) {
            if(logined){
                if(completed){
                    completed();
                }
            }
        }];
    }
}


- (void)fj_showRegisterFromViewController:(UIViewController *)viewController  inviteCode:(NSString *)inviteCode callback:(void(^)(BOOL logined))callback{
    FJRegisterViewControllerfj *vc = [FJRegisterViewControllerfj new];
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
