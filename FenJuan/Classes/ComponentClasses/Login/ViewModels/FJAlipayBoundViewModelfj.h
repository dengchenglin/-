//
//  CTAlipayBoundViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface FJAlipayBoundViewModelfj : CTViewModel
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) RACSignal *validBoundSignal;

@end
