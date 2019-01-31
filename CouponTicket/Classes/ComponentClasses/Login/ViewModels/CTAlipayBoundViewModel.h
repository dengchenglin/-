//
//  CTAlipayBoundViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface CTAlipayBoundViewModel : CTViewModel

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) RACSignal *validBoundSignal;

@end
