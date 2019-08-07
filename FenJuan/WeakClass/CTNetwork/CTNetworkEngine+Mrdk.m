//
//  CTNetworkEngine+Mrdk.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/26.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Mrdk.h"

#define CTMrdk(path)   [CTUrlPath(@"signin_activity") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Mrdk)
//打卡首页
- (CLRequest *)mrdkIndexWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTMrdk(@"index") params:nil callback:callback];
}
//我的记录
- (CLRequest *)mrdkRecordWithCallback:(CTResponseBlock)callback{
    return [self postWithPath:CTMrdk(@"record") params:nil callback:callback];
}

//报名
- (CLRequest *)sa_regWithPayType:(CTMrdkPayType)payType money:(NSString *)money password:(NSString *)password activityId:(NSString *)activityId callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(payType) forKey:@"pay_type"];
    [params setValue:money forKey:@"money"];
    [params setValue:activityId forKey:@"activity_id"];
    [params setValue:password forKey:@"pay_pwd"];
    return [self postWithPath:CTMrdk(@"reg") params:params callback:callback];
}
//打卡
- (CLRequest *)sa_signInWithCallback:(CTResponseBlock)callback{
  
    return [self postWithPath:CTMrdk(@"sign_in") params:nil callback:callback];
}
@end
