
//
//  CTUserInfoModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTUserInfoModel.h"

@implementation CTUserInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"day30_lists":CTEarnIndexModel.class,@"user":CTUser.class,@"people":CTUser.class};
}
@end
