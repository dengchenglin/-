//
//  CTForgetpsdViewModel.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTForgetpsdViewModel.h"

@implementation CTForgetpsdViewModel

- (void)initialize{
    //手机号不能为空
    self.validNextSignal = [RACSignal combineLatest:@[RACObserve(self, mobile)] reduce:^(NSString *mobile){
        return @(mobile.wipSpace.length);
    }];
}


@end
