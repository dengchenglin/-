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

- (UIViewController *)pushCashFromViewController:(UIViewController *)viewController{
    __block CTWithdrawViewController *vc;
    void(^cashBlock)(void) = ^{
        vc = [CTWithdrawViewController new];
        [viewController.navigationController pushViewController:vc animated:YES];
    };
    void(^checkPaypwdBlock)(void) = ^{
        if([CTAppManager user].ishas_pay_pwd){
            cashBlock();
        }
        else{
            [[CTModuleManager loginService]pushWithdrawSetpsdFromViewController:viewController mobile:[CTAppManager user].phone completed:^{
                [viewController.navigationController popToViewController:viewController animated:NO];
                cashBlock();
            }];
        }
    };
    if([CTAppManager user].ishas_cash_account){
        checkPaypwdBlock();
    }
    else{
        [[CTModuleManager loginService] pushBoundAlipayFromViewController:viewController completed:^{
            [viewController.navigationController popToViewController:viewController animated:NO];
            checkPaypwdBlock();
        }];
    }
    return vc;
}

@end
