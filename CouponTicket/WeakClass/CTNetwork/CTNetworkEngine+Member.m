//
//  CTNetworkEngine+Member.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Member.h"

#define CTUser(path)   [CTUrlPath(@"user") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Member)
//会员信息
- (CLRequest *)userIndexWithCallback:(CTResponseBlock)callback{
    NSString *path = CLDocumentPath(@"user_index");
    NSDictionary *data = [[NSDictionary alloc]initWithContentsOfFile:path];
    if(callback && data){
        callback(data,nil,0);
    }
    return [self postWithPath:CTUser(@"index") params:nil callback:^(id data, CLRequest *request, CTNetError error) {
        if(callback){
            callback(data,request,error);
        }
        if(!error){
            [((NSDictionary *)data) writeToFile:path atomically:YES];
        }
    }];
}
//会员权益
- (CLRequest *)userPowerWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTUser(@"user_power") params:nil callback:callback];
}

//我的收益
- (CLRequest *)userInfoWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTUser(@"my") params:nil callback:callback];
}
//常见问题
- (CLRequest *)oftenProblemWithPage:(NSInteger)page size:(NSInteger)size name:(NSString *)name callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:name forKey:@"name"];
    return [self postWithPath:CTUser(@"often_problem") params:nil callback:callback];
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
@end
