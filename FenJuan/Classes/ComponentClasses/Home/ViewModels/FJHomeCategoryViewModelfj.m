//
//  CTHomeCategoryViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHomeCategoryViewModelfj.h"


@implementation FJHomeCategoryViewModelfj

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sortType = CTGoodSortComprehensive;
    }
    return self;
}

- (void)setSortType:(CTGoodSortType)sortType{
    _sortType = sortType;
    _order = GetGoodsOrderStr(_sortType);
}

@end
