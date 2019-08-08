
//
//  CTHomeModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHomeModelfj.h"

@implementation CTHomeCurTimeBuyModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"goods":[CTGoodsModel class]};
}
@end

@implementation CTHomeHotGoodsModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"goods":[CTGoodsModel class]};
}
@end

@implementation FJHomeModelfj

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"cate":CTCategoryModel.class,@"activity":CTActivityModel.class,@"activity_banner":CTActivityModel.class,@"advs":CTActivityModel.class,@"cur_time_buy":CTHomeCurTimeBuyModel.class,@"now_goods":CTGoodsModel.class,@"hot_goods":CTHomeHotGoodsModel.class};
}
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"now_goods":@"new_goods"};
}
@end
