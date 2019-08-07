//
//  CTCategory.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/20.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTCategoryModel.h"

@implementation CTCategoryModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"title":@"cate_title"};
}

@end
