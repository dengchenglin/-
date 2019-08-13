//
//  CTGetCodeViewModel.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "FJGetCodeViewModelfj.h"

@implementation FJGetCodeViewModelfj

- (void)initialize{
    //邀请码和手机号不能为空
    self.validNextSignal = [RACSignal combineLatest:@[RACObserve(self, mobile),RACObserve(self, code)] reduce:^(NSString *mobile,NSString *code){
        return @(mobile.wipSpace.length && code.wipSpace.length);
    }];
}


@end
