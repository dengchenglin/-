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

- (CLRequest *)indexWithCallback:(CTResponseBlock)callback isCaches:(BOOL)isCaches{
    NSString *cachesPath = CLDocumentPath(@"home_index");
    
    NSDictionary *cachesData = [[NSDictionary alloc]initWithContentsOfFile:cachesPath];
    if(callback && cachesData && isCaches){
        callback(cachesData,nil,0);
    }
    return  [self postWithPath:CTIndex(@"index") params:nil showHud:cachesData?NO:YES callback:^(id data, CLRequest *request, CTNetError error) {
        if(callback){
            callback(data,request,error);
        }
        if(!error){
            [((NSDictionary *)data) writeToFile:cachesPath atomically:YES];
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
- (CLRequest *)cateWithPid:(NSString *)pid callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:pid forKey:@"pid"];
    return [self postWithPath:CTIndex(@"cate") params:params showHud:NO callback:callback];
}
//分类商品
- (CLRequest *)cateGoodsWithPage:(NSInteger)page size:(NSInteger)size cateId:(NSString *)cateId order:(NSString *)order callback:(CTResponseBlock)callback{
    return [self cateGoodsWithPage:page size:size cateId:cateId order:order showHud:YES callback:callback];
}
- (CLRequest *)cateGoodsWithPage:(NSInteger)page size:(NSInteger)size cateId:(NSString *)cateId order:(NSString *)order showHud:(BOOL)showHud callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:cateId forKey:@"cate_id"];
    [params setValue:order forKey:@"order"];

    return [self postWithPath:CTIndex(@"cate_goods") params:params showHud:showHud callback:callback];
}

- (CLRequest *)_cateWithPid:(NSString *)pid callback:(CTResponseBlock)callback{
    return [self cateWithPid:pid callback:callback cachesType:CTNetCachesNone];
}
- (CLRequest *)cateWithPid:(NSString *)pid callback:(CTResponseBlock)callback cachesType:(CTNetCachesType)cachesType{
    NSString *cachesPath = CLDocumentPath(@"index_cate");
    NSArray *cachesData = [[NSArray alloc]initWithContentsOfFile:cachesPath];
    if(callback && cachesData &&  (cachesType != CTNetCachesNone)){
        callback(cachesData,nil,0);
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:pid forKey:@"pid"];
    return [self postWithPath:CTIndex(@"cate") params:params showHud:NO callback:^(id data, CLRequest *request, CTNetError error) {
        if(callback){
            if((cachesType != CTNetCachesJust) || !cachesData){
                callback(data,request,error);
            }
        }
        if(!error && !pid.length){
            [((NSArray *)data) writeToFile:cachesPath atomically:YES];
        }
    }];
}

//活动列表数据
- (CLRequest *)activityGoodsWithPage:(NSInteger)page size:(NSInteger)size activityId:(NSString *)activityId order:(NSString *)order callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:activityId forKey:@"activity_id"];
    [params setValue:order forKey:@"order"];
    
    return [self postWithPath:CTIndex(@"activity_goods") params:params showHud:page>1?NO:YES callback:callback];
}

//实时热销榜
- (CLRequest *)hotGoodsWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTIndex(@"hot_goods") params:nil callback:callback];
}
@end
