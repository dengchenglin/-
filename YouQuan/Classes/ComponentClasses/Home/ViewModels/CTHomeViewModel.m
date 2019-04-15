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
    if(model.cur_time_buy.goods.count){
        viewModel.spreeHeight = 50 + (model.cur_time_buy.goods.count + 2)/3 * 230;
    }
    else{
        viewModel.spreeHeight = 0;
    }
    if(model.hot_goods.goods.count){
        viewModel.saleHeight = 260;
    }
    else{
        viewModel.saleHeight = 0;
    }
    return viewModel;
}

@end
