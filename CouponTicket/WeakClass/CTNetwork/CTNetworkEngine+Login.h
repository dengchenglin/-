//
//  CTNetworkEngine+Login.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

typedef NS_ENUM(NSInteger,CTLoginType) {
    CTLoginPhone = 1,
    CTLoginWeChat,
    CTLoginQQ
};
typedef NS_ENUM(NSInteger,CTSendCodeType) {
    CTSendCodeRegister = 1,
    CTSendCodeLogin,
    CTSendCodeResetinfo,
    CTSendCodeResetpwd
};


NSString * GetSendCodeStr(CTSendCodeType type);

@interface CTNetworkEngine (Login)

//注册
- (CLRequest *)registerWithPhone:(NSString *)phone pwd:(NSString *)pwd
                         type:(CTLoginType)type ivCode:(NSString *)ivCode smsCode:(NSString *)smsCode openid:(NSString *)openid nickname:(NSString *)nickname headicon:(NSString *)headicon unionid:(NSString *)unionid callback:(CTResponseBlock)callback;
//登录
- (CLRequest *)loginWithType:(CTLoginType)type openid:(NSString *)openid phone:(NSString *)phone pwd:(NSString *)pwd callback:(CTResponseBlock)callback;

//发送验证码
- (CLRequest *)smsSendWithPhone:(NSString *)phone type:(CTSendCodeType)type callback:(CTResponseBlock)callback;
@end
