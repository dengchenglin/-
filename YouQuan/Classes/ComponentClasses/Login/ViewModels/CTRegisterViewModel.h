//
//  CTRegisterViewModel.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface CTRegisterViewModel : CTViewModel

@property (nonatomic, copy) NSString *inviteCode;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, strong) RACSignal *validNextSignal;

@end
