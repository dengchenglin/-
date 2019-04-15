//
//  CTOrderViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTOrderViewModel.h"

@implementation CTOrderViewModel

+ (id)bindModel:(id)model{
    CTOrderViewModel *viewModel = [CTOrderViewModel new];
    viewModel.model = model;
    return viewModel;
}

@end
