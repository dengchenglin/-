//
//  CTEarnTrendModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTEarnTrendModel.h"

@implementation CTEarnTrendModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"day30_lists":CTEarnIndexModel.class};
}
@end
