//
//  CTJdpIndexModel.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTJdpIndexModel.h"

@implementation CTJdpIndexModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"Id":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"item":CTGoodsModel.class};
}
@end
