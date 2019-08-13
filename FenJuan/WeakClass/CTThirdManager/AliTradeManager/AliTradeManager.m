//
//  AliTradeManager.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "AliTradeManager.h"

#import <AlibcTradeSDK/AlibcTradeSDK.h>

#import <AlibabaAuthSDK/ALBBSDK.h>

#import "AliTradeWebViewController.h"

#define CTTBBackScheme @"tbopen27751631"

@implementation AliTradeManager

+ (void)initSDK{
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
         NSLog(@"AlibcTradeSDK init Success");
    } failure:^(NSError *error) {
        NSLog(@"Init failed: %@", error.description);
    }];
    // 开发阶段打开日志开关，方便排查错误信息
    //默认调试模式打开日志,release关闭,可以不调用下面的函数
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];
    
    // 配置全局的淘客参数
    //如果没有阿里妈妈的淘客账号,setTaokeParams函数需要调用
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = @"mm_318020083"; //mm_XXXXX为你自己申请的阿里妈妈淘客pid
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    //    //设置全局的app标识，在电商模块里等同于isv_code
    //    //没有申请过isv_code的接入方,默认不需要调用该函数
    //    [[AlibcTradeSDK sharedInstance] setISVCode:@"your_isv_code"];
    
    // 设置全局配置，是否强制使用h5
    //[[AlibcTradeSDK sharedInstance] setIsForceH5:NO];
    
}
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return  [[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:application];
}


+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options{
     return [[AlibcTradeSDK sharedInstance] application:application openURL:url options:options];
}


+ (void)openTbWithViewController:(UIViewController *)viewController url:(NSString *)url{
    if(!url.length)return;
    if([self isInstallTb]){
        AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
        showParam.openType = AlibcOpenTypeNative;
        showParam.backUrl = CTTBBackScheme;
        id<AlibcTradePage> page = [AlibcTradePageFactory page:url];

        [[AlibcTradeSDK sharedInstance].tradeService show: viewController.navigationController page:page showParams:showParam taoKeParams: nil trackParam: nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
            NSLog(@"%@",result);
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
            NSLog(@"%@",error);
        }];
    }
    else{
         AliTradeWebViewController *vc = [[AliTradeWebViewController alloc]init];
         vc.url = url;
        [viewController.navigationController pushViewController:vc animated:YES];
    }


}


+ (BOOL)isLogin{
    return [[ALBBSession sharedInstance] isLogin];
}

+(void)logOut{
    [[ALBBSDK sharedInstance]logout];
}
+ (BOOL)isInstallTb{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
}

+ (void)autoWithViewController:(UIViewController *)viewController successCallback:(void(^)(ALBBSession *session))successCallback{
    if(![self isInstallTb]){
        if(successCallback){
            successCallback(nil);
        }
        return;
    }
    if([self isLogin]){
        if(successCallback){
            successCallback([ALBBSession sharedInstance]);
        }
    }
    else{
        [[ALBBSDK sharedInstance]auth:viewController successCallback:^(ALBBSession *session) {
            if(successCallback){
                successCallback(session);
            }
            
        } failureCallback:^(ALBBSession *session, NSError *error) {
            NSLog(@"%@",error);
            [MBProgressHUD showMBProgressHudWithTitle:@"淘宝授权失败!"];
        }];
    }
}

@end
