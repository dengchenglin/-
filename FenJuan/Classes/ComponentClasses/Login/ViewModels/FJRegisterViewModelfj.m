//
//  CTRegisterViewModel.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "FJRegisterViewModelfj.h"

@implementation FJRegisterViewModelfj

- (void)initialize{
    //邀请码和手机号不能为空
    self.validNextSignal = [RACSignal combineLatest:@[RACObserve(self, inviteCode),RACObserve(self, mobile)] reduce:^(NSString *inviteCode,NSString *mobile){
        return @(inviteCode.wipSpace.length && mobile.wipSpace.length);
    }];
}

@end
