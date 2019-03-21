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
- (CLRequest *)goodsUrlConvertWithTbGoodUrl:(NSString *)goodUrl tbCode:(NSString *)tbCode tbToken:(NSString *)tbToken callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:goodUrl forKey:@"coupon_share_url"];
    [params setValue:tbCode forKey:@"tb_code"];
    [params setValue:tbToken forKey:@"tb_token"];
    return [self postWithPath:CTGoods(@"goods_url_convert") params:params callback:callback];
}

//搜索
- (CLRequest *)goodsSearchWithKeyword:(NSString *)keyword page:(NSInteger)page size:(NSInteger)size order:(NSString *)order callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:order forKey:@"order"];
    return [self postWithPath:CTGoods(@"goods_search") params:params showHud:NO callback:callback];
}

//商品收藏
- (CLRequest *)favoriteWithGoodsId:(NSString *)goodsId isFavorite:(BOOL)isFavorite callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:goodsId forKey:@"goods_id"];
    [params setValue:@(isFavorite) forKey:@"is_favorite"];
    return [self postWithPath:CTGoods(@"favorite") params:params callback:callback];
}

//热搜和搜索历史
- (CLRequest *)searchHistoryWithCallback:(CTResponseBlock)callback{
    NSString *path = CLDocumentPath(@"search_history");
    
    NSDictionary *data = [[NSDictionary alloc]initWithContentsOfFile:path];
    if(callback && data){
        callback(data,nil,0);
    }
    return  [self postWithPath:CTGoods(@"search_history") params:nil callback:^(id data, CLRequest *request, CTNetError error) {
        if(callback){
            callback(data,request,error);
        }
        if(!error){
            [((NSDictionary *)data) writeToFile:path atomically:YES];
        }
    }];
   
}

@end
