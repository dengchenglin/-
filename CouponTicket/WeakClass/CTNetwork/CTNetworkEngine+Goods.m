//
//  CTNetworkEngine+Goods.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Goods.h"

#define CTGoods(path)   [CTUrlPath(@"goods") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Goods)

//商品详情
- (CLRequest *)goodsDetailWithId:(NSString *)Id callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:Id forKey:@"id"];
    return [self postWithPath:CTGoods(@"goodsDetail") params:params callback:callback];
}

//获取商品链接（转链）
- (CLRequest *)goodsUrlConvertWithTbGoodId:(NSString *)tbGoodId callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:tbGoodId forKey:@"tb_goods_id"];
    return [self postWithPath:CTGoods(@"goods_url_convert") params:params callback:callback];
}

//搜索
- (CLRequest *)goodsSearchWithKeyword:(NSString *)keyword page:(NSInteger)page size:(NSInteger)size order:(NSString *)order callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:order forKey:@"order"];
    return [self postWithPath:CTGoods(@"goods_search") params:params callback:callback];
}

@end
