
//
//  CTEarnRankModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTEarnRankModel.h"
@implementation CTEarnRankIndexModel
@end
@implementation CTEarnRankModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"yesterday":CTEarnRankIndexModel.class,@"month":CTEarnRankIndexModel.class,@"last_month":CTEarnRankIndexModel.class,@"all":CTEarnRankIndexModel.class};
}
@end
