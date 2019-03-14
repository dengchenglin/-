//
//  CTHomeCategoryViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeCategoryViewModel.h"

NSString *GetOrderStr(CTGoodSortType type){
    switch (type) {
        case CTGoodSortComprehensive:
            return @"sort";
            break;
        case CTGoodSortSales:
            return @"package_sale";
            break;
        case CTGoodSortNewest:
            return @"create_at";
            break;
        case CTGoodSortDiscountUp:
            return @"coupon_amount_up";
            break;
        case CTGoodSortDiscountDown:
            return @"coupon_amount_down";
            break;
        case CTGoodSortPriceUp:
            return @"sale_price_up";
            break;
        case CTGoodSortPriceDown:
            return @"sale_price_down";
            break;
        default:
            break;
    }
    return @"sort";
}

@implementation CTHomeCategoryViewModel

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
    _order = GetOrderStr(_sortType);
}

@end
