//
//  CTNetworkEngine+Member.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Member.h"

#import "LMUpdateData.h"

#define CTUser(path)   [CTUrlPath(@"user") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Member)

//获取我的邀请码
- (NSString *)qCodeUrl{
    NSString *path = [NSString stringWithFormat:@"api/user/user_qr.html?token=%@",[CTAppManager sharedInstance].token];
    return CTBaseUrl(path);
}

//会员信息
- (CLRequest *)userIndexWithCallback:(CTResponseBlock)callback{
    NSString *cachesPath = CLDocumentPath(@"user_index");
    NSDictionary *cachesData = [[NSDictionary alloc]initWithContentsOfFile:cachesPath];
    if(callback && cachesData){
        callback(cachesData,nil,0);
    }
    return [self postWithPath:CTUser(@"index") params:nil showHud:cachesData?NO:YES callback:^(id data, CLRequest *request, CTNetError error) {
        if(callback){
            callback(data,request,error);
        }
        if(!error){
            [((NSDictionary *)data) writeToFile:cachesPath atomically:YES];
        }
    }];
}
//会员权益
- (CLRequest *)userPowerWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTUser(@"user_power") params:nil callback:callback];
}

//我的收益
- (CLRequest *)userInfoWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTUser(@"my") params:nil showHud:NO callback:callback];
}
//常见问题
- (CLRequest *)oftenProblemWithPage:(NSInteger)page size:(NSInteger)size name:(NSString *)name callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:name forKey:@"name"];
    return [self postWithPath:CTUser(@"often_problem") params:params showHud:page>1?NO:YES callback:callback];
}
//我的团队-分类
- (CLRequest *)teamCateWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTUser(@"team_cate") params:nil callback:callback];
}
//我的团队-列表
- (CLRequest *)teamListWithCateId:(NSString *)cateId page:(NSInteger)page size:(NSInteger)size  callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:cateId forKey:@"cate_id"];
    return [self postWithPath:CTUser(@"team_list") params:params callback:callback];
}
//热门分类和猜你喜欢
- (CLRequest *)hotGoodsCateWithCallback:(CTResponseBlock)callback{
    NSString *cachesPath = CLDocumentPath(@"hot_goods_cate");
    NSDictionary *cachesData = [[NSDictionary alloc]initWithContentsOfFile:cachesPath];
    if(callback && cachesData){
        callback(cachesData,nil,0);
    }
    return [self postWithPath:CTUser(@"hot_goods_cate") params:nil showHud:cachesData?NO:YES callback:^(id data, CLRequest *request, CTNetError error) {
        if(callback){
            callback(data,request,error);
        }
        if(!error){
            [((NSDictionary *)data) writeToFile:cachesPath atomically:YES];
        }
    }];
}

//我的收藏
- (CLRequest *)myGoodsFavoriteWithPage:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    return [self postWithPath:CTUser(@"my_goods_favorite") params:params showHud:page>1?NO:YES callback:callback];
}
- (CLRequest *)setPaypwdWithPhone:(NSString *)phone pwd:(NSString *)pwd smsCode:(NSString *)smsCode callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    [params setValue:pwd forKey:@"pwd"];
    [params setValue:smsCode forKey:@"sms_code"];
    return [self postWithPath:CTUser(@"set_paypwd") params:params callback:callback];
}
//意见反馈
- (CLRequest *)viewSaveWithDetail:(NSString *)detail img:(NSArray <NSString *>*)imgs callback:(CTResponseBlock)callback{
    NSMutableString *imgStr = [NSMutableString string];
    for(NSString *img in imgs){
        [imgStr appendFormat:@"%@,",LMImageUrlForKey(img)];
    }
    if(imgStr.length){
        [imgStr deleteCharactersInRange:NSMakeRange(imgStr.length - 1, 1)];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:detail forKey:@"detail"];
    [params setValue:imgStr forKey:@"imgs"];
    return [self postWithPath:CTUser(@"view_save") params:params callback:callback];
}

//收益明细
- (CLRequest *)incomeDetailWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTUser(@"income_detail") params:nil callback:callback];
}
//收益走势
- (CLRequest *)incomeTrendWithCallback:(CTResponseBlock)callback{
     return [self postWithPath:CTUser(@"income_trend") params:nil callback:callback];
}
//用户详情
- (CLRequest *)teamUserDetailWithUid:(NSString *)uid callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:uid forKey:@"uid"];
    return [self postWithPath:CTUser(@"team_user_detail") params:params callback:callback];
}

@end
