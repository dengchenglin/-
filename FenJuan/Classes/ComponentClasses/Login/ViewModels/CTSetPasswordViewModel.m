//
//  CTSetPasswordViewModel.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTSetPasswordViewModel.h"

@implementation CTSetPasswordViewModel

- (void)initialize{
    //两次密码不能为空
    self.validRegisterSignal = [RACSignal combineLatest:@[RACObserve(self, password),RACObserve(self, repassword)] reduce:^(NSString *password,NSString *repassword){
        return @(password.wipSpace.length && repassword.wipSpace.length);
    }];
}

- (BOOL)psdConsistented{
    return [self.password isEqualToString:self.repassword];
}

@end
