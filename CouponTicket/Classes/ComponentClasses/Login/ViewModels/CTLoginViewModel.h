//
//  CTLoginViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface CTLoginViewModel : CTViewModel

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) RACSignal *validLoginSignal;

@end
