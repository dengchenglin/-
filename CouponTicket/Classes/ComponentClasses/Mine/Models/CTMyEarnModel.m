//
//  CTMyEarnModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMyEarnModel.h"

@implementation CTEarnInfo

@end
@implementation CTMyEarnModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"today":CTEarnInfo.class,@"yesterday":CTEarnInfo.class,@"month":CTEarnInfo.class,@"last_month":CTEarnInfo.class};
}

@end
