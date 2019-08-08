//
//  CTGetCodeViewModel.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface CTGetCodeViewModel : CTViewModel
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) RACSignal *validNextSignal;

@end
