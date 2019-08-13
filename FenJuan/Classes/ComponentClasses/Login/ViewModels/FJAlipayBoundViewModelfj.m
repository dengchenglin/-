//
//  CTAlipayBoundViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJAlipayBoundViewModelfj.h"

@implementation FJAlipayBoundViewModelfj

- (void)initialize{
    //账号和密码不能为空
    self.validBoundSignal = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, name)] reduce:^(NSString *account,NSString *name){
        return @(account.wipSpace.length && name.wipSpace.length);
    }];
}

@end
