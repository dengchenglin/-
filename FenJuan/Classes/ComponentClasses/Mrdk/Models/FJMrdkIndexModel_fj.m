//
//  CTMrdkIndexModel.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJMrdkIndexModel_fj.h"

@implementation CTMrdkMoneyCate


@end

@implementation CTMrdkActivity
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"Id":@"id"};
}

@end



@implementation CTMrdkUser


@end

@implementation CTMrdkTodayActivityRecord

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"user1":CTMrdkUser.class,@"user2":CTMrdkUser.class,@"user3":CTMrdkUser.class};
}

@end

@implementation FJMrdkIndexModel_fj

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"money_cate":CTMrdkMoneyCate.class,@"activity":CTMrdkActivity.class,@"my_score":FJMrdkMyScoreFj.class,@"today_activity_record":CTMrdkTodayActivityRecord.class};
}

@end

