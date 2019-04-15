//
//  CTHomeViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

#import "CTCategoryModel.h"

#import "CTHomeModel.h"

#import "CTGoodsViewModel.h"

@interface CTHomeViewModel : CTViewModel

@property (nonatomic, strong) CTHomeModel *model;

@property (nonatomic, copy) NSArray <CTGoodsViewModel *> *now_goods;

@property (nonatomic, assign) CGFloat spreeHeight;

@property (nonatomic, assign) CGFloat saleHeight;

@end
