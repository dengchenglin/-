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

NSString *GetGrabTypeStr(NSInteger type){
    switch (type) {
        case 1:
            return @"即将开始";
            break;
        case 2:
            return @"商品已抢光";
            break;
        case 3:
            return @"商品正在快抢中";
            break;
        default:
            break;
    }
    return @"";
}
@implementation CTSeckillContentModel


@end

@implementation CTGoodsModel


+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"cpy_content":@"copy_content",@"itempics":@"itempic",@"comments":@"comment",@"cpy_comments":@"copy_comment",@"show_comments":@"show_comment",@"video":@"video_url"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"goods":CTGoodsModel.class,@"seckill_content":CTSeckillContentModel.class,@"item_data":CTGoodsModel.class};
}


@end
