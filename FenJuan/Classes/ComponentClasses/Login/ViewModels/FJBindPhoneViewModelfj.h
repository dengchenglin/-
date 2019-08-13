//
//  CTBindPhoneViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface FJBindPhoneViewModelfj : CTViewModel
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, strong) RACSignal *validNextSignal;

@end
