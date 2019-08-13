//
//  CTEarnTrendModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJEarnTrendModelfj.h"

@implementation FJEarnTrendModelfj
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"day30_lists":CTEarnIndexModel.class};
}
@end
