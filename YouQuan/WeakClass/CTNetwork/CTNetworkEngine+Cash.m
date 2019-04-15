//
//  CTNetworkEngine+BoundPayAccount.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/29.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Cash.h"

#define CTCash(path)   [CTUrlPath(@"cash") stringByAppendingPathComponent:path]


@implementation CTNetworkEngine (Cash)

- (CLRequest *)accountSaveWithAccount:(NSString *)account username:(NSString *)username phone:(NSString *)phone smsCode:(NSString *)smsCode callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    [params setValue:account forKey:@"account"];
    [params setValue:username forKey:@"username"];
    [params setValue:smsCode forKey:@"sms_code"];
    return [self postWithPath:CTCash(@"acount_save") params:params callback:callback];
}
//提现页面
- (CLRequest *)cashIndexWithCallback:(CTResponseBlock)callback;{
    return [self postWithPath:CTCash(@"index") params:nil callback:callback];
}
- (CLRequest *)cashSaveWithPaypwd:(NSString *)paypwd money:(NSString *)money callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:paypwd forKey:@"pay_pwd"];
    [params setValue:money forKey:@"money"];
    return [self postWithPath:CTCash(@"save") params:params callback:callback];
}
@end
