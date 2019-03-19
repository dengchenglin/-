//
//  CTNetworkEngine+Index.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Index.h"

#define CTIndex(path)   [CTUrlPath(@"index") stringByAppendingPathComponent:path]


@implementation CTNetworkEngine (Index)

- (CLRequest *)indexWithCallback:(CTResponseBlock)callback{
    NSString *path = CLDocumentPath(CTIndex(@"index"));
    NSDictionary *data = [[NSDictionary alloc]initWithContentsOfFile:path];
    if(callback && data){
        callback(data,nil,0);
    }
    return  [self postWithPath:CTIndex(@"index") params:nil callback:^(id data, CLRequest *request, CTNetError error) {
        if(callback){
            callback(data,request,error);
        }
        if(!error){
            [((NSDictionary *)data) writeToFile:path atomically:YES];
        }
    }];
}
//当前整点抢购
- (CLRequest *)curTimeBuyWithTime:(NSString *)time callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:time forKey:@"phone"];
    return [self postWithPath:CTIndex(@"cur_time_buy") params:params callback:callback];
}
//二级分类
- (CLRequest *)cateWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTIndex(@"cate") params:nil showHud:NO callback:callback];
}
//分类商品
- (CLRequest *)cateGoodsWithPage:(NSInteger)page size:(NSInteger)size cateId:(NSString *)cateId order:(NSString *)order callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:cateId forKey:@"cate_id"];
    [params setValue:order forKey:@"order"];

    return [self postWithPath:CTIndex(@"cate_goods") params:params callback:callback];
}

//活动列表数据
- (CLRequest *)activityGoodsWithPage:(NSInteger)page size:(NSInteger)size activityId:(NSString *)activityId order:(NSString *)order callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:activityId forKey:@"activity_id"];
    [params setValue:order forKey:@"order"];
    
    return [self postWithPath:CTIndex(@"activity_goods") params:params callback:callback];
}

//实时热销榜
- (CLRequest *)hotGoodsWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTIndex(@"hot_goods") params:nil callback:callback];
}
@end
