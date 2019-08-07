//
//  CTNetworkEngine+ProGood.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+ProGood.h"
#define CTProGood(path)   [CTUrlPath(@"thirld_tk") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (ProGood)

//发圈
- (CLRequest *)fqGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"cate_id"];
    [params setValue:minId forKey:@"min_id"];
    return [self postWithPath:CTProGood(@"fq_goods") params:params showHud:minId?NO:YES callback:callback];
}

//多品
- (CLRequest *)fqMultipleGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"2" forKey:@"cate_id"];
    [params setValue:minId forKey:@"min_id"];
    return [self postWithPath:CTProGood(@"fq_goods") params:params showHud:minId?NO:YES callback:callback];
}

//宣传素材
- (CLRequest *)fqMaterialGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"3" forKey:@"cate_id"];
    [params setValue:minId forKey:@"min_id"];
    return [self postWithPath:CTProGood(@"fq_goods") params:params showHud:minId?NO:YES callback:callback];
}

- (CLRequest *)fastbuyCateWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTProGood(@"fastbuy_cate") params:nil callback:callback];
}

//快抢列表
- (CLRequest *)fastbuyGoodsWithCateId:(NSString *)cateId page:(NSInteger)page callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:cateId forKey:@"cate_id"];
    return [self postWithPath:CTProGood(@"fastbuy_goods") params:params showHud:page>1?NO:YES callback:callback];
}
@end
