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
    CTWithdrawViewController *vc = [CTWithdrawViewController new];
    void(^cashBlock)(void) = ^{
        [viewController.navigationController pushViewController:vc animated:YES];
    };
    if([CTAppManager user].ishas_cash_account){
        cashBlock();
    }
    else{
        [[CTModuleManager loginService] pushBoundAlipayFromViewController:viewController completed:^{
            [viewController.navigationController popToViewController:viewController animated:YES];
            cashBlock();
        }];
    }
    return vc;
}

@end
