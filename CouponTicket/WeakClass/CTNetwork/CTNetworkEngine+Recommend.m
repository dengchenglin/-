//
//  CTNetworkEngine+Recommend.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Recommend.h"

#define CTRecom(path)   [CTUrlPath(@"recom") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Recommend)
//整点抢购时间列表
- (CLRequest *)allTimeBuyWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTRecom(@"all_time_buy") params:nil callback:callback];
}
//整点抢购商品列表
- (CLRequest *)timeBuyGoodsWithPage:(NSInteger)page size:(NSInteger)size markeId:(NSString *)markeId callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:markeId forKey:@"marke_id"];
    return [self postWithPath:CTRecom(@"time_buy_goods") params:nil callback:callback];
}
@end
