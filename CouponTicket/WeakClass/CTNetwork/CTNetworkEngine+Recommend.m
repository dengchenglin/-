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
    return [self postWithPath:CTRecom(@"time_buy_goods") params:params callback:callback];
}
//视频购商品分类
- (CLRequest *)videoBuyCateWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTRecom(@"video_buy_cate") params:nil callback:callback];
}
//视频购商品列表
- (CLRequest *)videoBuyGoodsWithPage:(NSInteger)page size:(NSInteger)size cateId:(NSString *)cateId order:(NSString *)order callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:cateId forKey:@"cate_id"];
    [params setValue:order forKey:@"order"];
    return [self postWithPath:CTRecom(@"video_buy_goods") params:params callback:callback];
}
//官方精选
- (CLRequest *)officialBuyWithPage:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    return [self postWithPath:CTRecom(@"official_buy") params:params callback:callback];
}
//官方精选详情
- (CLRequest *)officialBuyDetailWithMarkeId:(NSString *)markeId callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:markeId forKey:@"marke_id"];
    return [self postWithPath:CTRecom(@"official_buy_detail") params:params callback:callback];
}
@end
