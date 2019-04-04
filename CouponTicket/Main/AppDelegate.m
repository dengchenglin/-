//
//  AppDelegate.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "AppDelegate.h"

#import "CTAppConfig.h"

#import "UMShareManager.h"

#import "UMMessageManager.h"

#import "AliTradeManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    id<CLModuleServiceProtocol> service = [CTModuleManager mainService];
    self.window.rootViewController = service.rootViewController;
    [self.window makeKeyAndVisible];
    [CTAppConfig config];
    [UMShareManager config];
    [UMMessageManager application:application didFinishLaunchingWithOptions:launchOptions];
    [AliTradeManager initSDK];
    

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [UMMessageManager registerDeviceToken:deviceToken];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if([UMShareManager application:application openURL:url sourceApplication:sourceApplication annotation:application]){
        return YES;
    }
    if([AliTradeManager application:application openURL:url sourceApplication:sourceApplication annotation:application]){
        return YES;
    }
    return NO;
}
+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    if([UMShareManager application:app openURL:url options:options]){
        return YES;
    }
    if([AliTradeManager application:app openURL:url options:options]){
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if([UMShareManager application:application handleOpenURL:url]){
        return YES;
    }
    return NO;
}


//iOS10以下使用这两个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMMessageManager application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

//iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    [UMMessageManager userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}

//iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    [UMMessageManager userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}


@end
