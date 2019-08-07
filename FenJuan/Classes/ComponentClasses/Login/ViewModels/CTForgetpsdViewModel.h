//
//  CTForgetpsdViewModel.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface CTForgetpsdViewModel : CTViewModel

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, strong) RACSignal *validNextSignal;

@end
