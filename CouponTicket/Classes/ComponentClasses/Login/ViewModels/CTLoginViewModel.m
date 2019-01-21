//
//  CTLoginViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginViewModel.h"

@implementation CTLoginViewModel

- (void)initialize{
    //账号和密码不能为空
    self.validLoginSignal = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, password)] reduce:^(NSString *account,NSString *password){
        return @(account.wipSpace.length && password.wipSpace.length);
    }];
}

@end
