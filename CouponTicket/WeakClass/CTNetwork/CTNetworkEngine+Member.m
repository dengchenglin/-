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
    NSString *path = CLDocumentPath(CTUser(@"index"));
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
@end
