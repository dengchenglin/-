//
//  CTNetworkEngine+ThirldTk.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/11.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+ThirldTk.h"
#define CTThirld(path)   [CTUrlPath(@"thirld_tk") stringByAppendingPathComponent:path]

NSString *getTypeStr(CTShopType type){
    switch (type) {
        case CTShopHqg:
            return @"hqg";
            break;
        case CTShopJhs:
            return @"jhs";
            break;
        case CTShop99by:
            return @"by9k9";
            break;
        default:
            break;
    }
    return @"";
}

@implementation CTNetworkEngine (ThirldTk)
- (CLRequest *)getGoodsWithShopType:(CTShopType)type order:(CTGoodSortType)order page:(NSInteger)page minId:(NSString *)minId callback:(CTResponseBlock)callback{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:minId forKey:@"min_id"];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(order) forKey:@"order"];
    return [self postWithPath:CTThirld(getTypeStr(type)) params:params showHud:page>1?NO:YES callback:callback];
}

//热卖商品
- (CLRequest *)hotSellingWithCateId:(NSString *)cateId saleType:(CTHotGoodsSaleType)saleType pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(pageIndex) forKey:@"page"];
    [params setValue:@(pageSize) forKey:@"size"];
    [params setValue:@(saleType) forKey:@"sale_type"];
    [params setValue:cateId forKey:@"cate_id"];
    return [self postWithPath:CTThirld(@"hot_selling") params:params showHud:pageIndex>1?NO:YES callback:callback];
}

//达人说
- (CLRequest *)hdktalentcatWithTablentcat:(NSString *)talentcat callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:talentcat forKey:@"talentcat"];
    return [self postWithPath:CTThirld(@"hdk_talentcat") params:params callback:callback];
}

//商品详情列表
- (CLRequest *)hdkTalentcatDetailWithId:(NSString *)Id callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:Id forKey:@"id"];
    return [self postWithPath:CTThirld(@"hdk_talentcat_detail") params:params callback:callback];
}


//聚大牌列表
- (CLRequest *)hdkJdpWithCateId:(NSString *)cateId minId:(NSString *)minId callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:cateId forKey:@"cate_id"];
    [params setValue:minId forKey:@"min_id"];
    return [self postWithPath:CTThirld(@"hdk_jdp") params:params callback:callback];
}

//聚大牌详情
- (CLRequest *)hdkJdpDetailWithId:(NSString *)Id minId:(NSString *)minId callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:Id forKey:@"id"];
    [params setValue:minId forKey:@"min_id"];
    return [self postWithPath:CTThirld(@"hdk_jdp_detail") params:params callback:callback];
}

//视频购
- (CLRequest *)hdkVideoBuyWithCateId:(NSString *)cateId minId:(NSString *)minId callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:cateId forKey:@"cate_id"];
    [params setValue:minId forKey:@"min_id"];
    return [self postWithPath:CTThirld(@"hdk_video_buy") params:params callback:callback];
}
@end
