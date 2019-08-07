//
//  CTBindPhoneViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface CTBindPhoneViewModel : CTViewModel
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, strong) RACSignal *validNextSignal;

@end
