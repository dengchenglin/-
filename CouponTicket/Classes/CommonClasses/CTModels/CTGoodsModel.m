//
//  CTGoodModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsModel.h"

NSString *GetGoodsOrderStr(CTGoodSortType type){
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
NSString *GetTypeImageStr(NSInteger status){
    switch (status) {
        case 1:
            return @"ic_label_1";
            break;
        case 2:
            return @"ic_label_2";
            break;
        case 3:
            return @"ic_label_3";
            break;
        default:
            break;
    }
    return @"";
}

@implementation CTGoodsModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"goods":CTGoodsModel.class};
}
@end
