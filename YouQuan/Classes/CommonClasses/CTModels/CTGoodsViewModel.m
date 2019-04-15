//
//  CTGoodsViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsViewModel.h"

@implementation CTGoodsViewModel

+ (id)bindModel:(id)model{
    CTGoodsViewModel *viewModel = [CTGoodsViewModel new];
    viewModel.model = model;
    return viewModel;
}


@end
