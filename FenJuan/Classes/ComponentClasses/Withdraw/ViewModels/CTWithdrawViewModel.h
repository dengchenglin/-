//
//  CTWithdrawViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface CTWithdrawViewModel : CTViewModel

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *balanceNotice;

@property (nonatomic, strong) RACSignal *withDrawButtonVaild;

@property (nonatomic, copy) UIColor *balanceNoticeColor;

@property (nonatomic, copy) NSString *withdrawAccount;

@property (nonatomic, copy) NSString *withdrawPassword;

@property (nonatomic, copy) NSString *withdrawName;

@property (nonatomic, copy) NSString *balanceNoticeText;

@end
