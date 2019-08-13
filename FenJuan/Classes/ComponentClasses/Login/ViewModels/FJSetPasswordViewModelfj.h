//
//  CTSetPasswordViewModel.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface FJSetPasswordViewModelfj : CTViewModel

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *repassword;

@property (nonatomic, strong) RACSignal *validRegisterSignal;

@property (nonatomic, assign) BOOL psdConsistented;

@end
