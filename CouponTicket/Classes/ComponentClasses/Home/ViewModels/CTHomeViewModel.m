//
//  CTHomeViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeViewModel.h"

@implementation CTHomeViewModel

+ (id)bindModel:(CTHomeModel *)model{
    CTHomeViewModel *viewModel = [CTHomeViewModel new];
    viewModel.model = model;
    viewModel.now_goods = [CTGoodsViewModel bindModels:model.now_goods];
    return viewModel;
}

@end
