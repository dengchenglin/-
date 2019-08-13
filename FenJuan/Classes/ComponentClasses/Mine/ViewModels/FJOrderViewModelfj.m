//
//  CTOrderViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJOrderViewModelfj.h"

@implementation FJOrderViewModelfj

+ (id)bindModel:(id)model{
    FJOrderViewModelfj *viewModel = [FJOrderViewModelfj new];
    viewModel.model = model;
    return viewModel;
}

@end
