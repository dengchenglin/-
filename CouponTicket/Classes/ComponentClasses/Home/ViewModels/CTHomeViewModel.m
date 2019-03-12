//
//  CTHomeViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeViewModel.h"

@implementation CTHomeViewModel

+ (id)bindModel:(id)model{
    CTHomeViewModel *viewModel = [CTHomeViewModel new];
    viewModel.model = model;
    return viewModel;
}

@end
