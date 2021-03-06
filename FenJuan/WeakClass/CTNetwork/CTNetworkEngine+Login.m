//
//  CTNetworkEngine+Login.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Login.h"

#define CTLogin(path)   [CTUrlPath(@"login") stringByAppendingPathComponent:path]

NSString * GetSendCodeStr(CTSendCodeType type){
    switch (type) {
        case CTSendCodeRegister:
            return @"yq_register";
            break;
        case CTSendCodeLogin:
            return @"yq_login";
            break;
        case CTSendCodeResetinfo:
            return @"yq_resetinfo";
            break;
        case CTSendCodeResetpwd:
            return @"yq_resetpwd";
            break;
        default:
            break;
    }
    return nil;
}

@implementation CTNetworkEngine (Login)

- (CLRequest *)fj_registerWithPhone:(NSString *)phone pwd:(NSString *)pwd
                         type:(CTLoginType)type ivCode:(NSString *)ivCode smsCode:(NSString *)smsCode openid:(NSString *)openid nickname:(NSString *)nickname headicon:(NSString *)headicon unionid:(NSString *)unionid callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    [params setValue:pwd forKey:@"pwd"];
    [params setValue:@(type) forKey:@"type"];
    [params setValue:ivCode forKey:@"iv_code"];
    [params setValue:smsCode forKey:@"sms_code"];
    [params setValue:openid forKey:@"openid"];
    [params setValue:nickname forKey:@"nickname"];
    [params setValue:headicon forKey:@"headimg"];
    [params setValue:unionid forKey:@"unionid"];
    return [self postWithPath:CTLogin(@"reg") params:params callback:callback];
    
}
- (CLRequest *)loginWithType:(CTLoginType)type openid:(NSString *)openid phone:(NSString *)phone pwd:(NSString *)pwd callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    [params setValue:pwd forKey:@"pwd"];
    [params setValue:@(type) forKey:@"type"];
    [params setValue:openid forKey:@"openid"];
    return [self postWithPath:CTLogin(@"index") params:params callback:callback];
}

- (CLRequest *)fj_smsSendWithPhone:(NSString *)phone type:(CTSendCodeType)type callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    [params setValue:GetSendCodeStr(type) forKey:@"type"];
    return [self postWithPath:CTLogin(@"sms_send") params:params callback:callback];
}

//检查手机号是否注册
- (CLRequest *)fj_checkPhoneWithPhone:(NSString *)phone callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    return [self postWithPath:CTLogin(@"check_phone") params:params showHud:YES showErrorHud:NO callback:callback];
}

- (CLRequest *)fj_checkPhoneWithPhone:(NSString *)phone showErrorHud:(BOOL)showErrorHud callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    return [self postWithPath:CTLogin(@"check_phone") params:params showHud:YES showErrorHud:showErrorHud callback:callback];
}

//修改密码
- (CLRequest *)fj_resetPwdWithPhone:(NSString *)phone pwd:(NSString *)pwd smsCode:(NSString *)smsCode callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    [params setValue:pwd forKey:@"pwd"];
    [params setValue:smsCode forKey:@"sms_code"];
    return [self postWithPath:CTLogin(@"reset_pwd") params:params callback:callback];
}

- (CLRequest *)fj_checkSmsCodeWithPhone:(NSString *)phone smsCode:(NSString *)smsCode callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    [params setValue:smsCode forKey:@"sms_code"];
    return [self postWithPath:CTLogin(@"check_sms_code") params:params callback:callback];
}

//校验邀请码或者手机号
- (CLRequest *)fj_checkIvcodeOrPhoneWithIvCode:(NSString *)ivCode phone:(NSString *)phone callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"phone"];
    [params setValue:ivCode forKey:@"iv_code"];
    return [self postWithPath:CTLogin(@"check_ivcode_or_phone") params:params callback:callback];
}

- (CLRequest *)fj_bindPhoneWithPhone:(NSString *)phone 
                             type:(CTLoginType)type ivCode:(NSString *)ivCode smsCode:(NSString *)smsCode openid:(NSString *)openid nickname:(NSString *)nickname headicon:(NSString *)headicon unionid:(NSString *)unionid callback:(CTResponseBlock)callback{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:phone forKey:@"phone"];
        [params setValue:@(type) forKey:@"type"];
        [params setValue:ivCode forKey:@"iv_code"];
        [params setValue:smsCode forKey:@"sms_code"];
        [params setValue:openid forKey:@"openid"];
        [params setValue:nickname forKey:@"nickname"];
        [params setValue:headicon forKey:@"headimg"];
        [params setValue:unionid forKey:@"unionid"];
        return [self postWithPath:CTLogin(@"bing_phone") params:params callback:callback];
}
@end
