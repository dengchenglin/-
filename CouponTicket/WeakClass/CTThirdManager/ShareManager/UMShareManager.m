//
//  ShareManager.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "UMShareManager.h"

#import <UMCommon/UMCommon.h>

#define UMAppKey @"5c7ce2030cafb2fa0c0000bc"

#define UMQQAppKey @"101548386"
#define UMQQAppSecrect @"3a5175aba30af70995bb1ea149134dd9"

#define UMWeChatAppKey @"wxa1721eeba2b8afa8"
#define UMWeChatSecrect @"4eeb74f2543e2183522de2cd7a8026dc"

@implementation UMShareManager

+ (void)config{
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure initWithAppkey:UMAppKey channel:@"App Store"];
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_QQ appKey:UMQQAppKey appSecret:UMWeChatSecrect redirectURL:nil];
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_WechatSession appKey:UMWeChatAppKey appSecret:UMWeChatSecrect redirectURL:nil];
}
// 支持所有iOS系统
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType completion:(void(^)(UMSocialUserInfoResponse *respone))completion{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        if(!error && completion){
            UMSocialUserInfoResponse *resp = result;
            completion(resp);
        }
    }];
}

@end
