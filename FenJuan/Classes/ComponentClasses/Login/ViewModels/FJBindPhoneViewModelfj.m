//
//  CTBindPhoneViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJBindPhoneViewModelfj.h"

@implementation FJBindPhoneViewModelfj
- (void)initialize{
    //手机号不能为空
    self.validNextSignal = [RACSignal combineLatest:@[RACObserve(self, mobile)] reduce:^(NSString *mobile){
        return @(mobile.wipSpace.length);
    }];
}
@end
