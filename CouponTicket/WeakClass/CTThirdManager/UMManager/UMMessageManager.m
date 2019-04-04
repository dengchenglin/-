//
//  UMMessageManager.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/12/3.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "UMMessageManager.h"

#import <objc/runtime.h>

#import <UMPush/UMessage.h>

#import <UMCommon/UMConfigure.h>

#import "Aspects.h"


@interface UMMessageManager()<UNUserNotificationCenterDelegate>

@end

@implementation UMMessageManager



+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        //class_addProtocol(application.delegate.class, @protocol(UNUserNotificationCenterDelegate));
        [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>)application.delegate;
    } else {

    };
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
    [application setApplicationIconBadgeNumber:0];
    NSDictionary *remoteNotificationInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(remoteNotificationInfo){
        [self didReceiveRemoteNotification:remoteNotificationInfo];
    }

    return YES;
}

+ (void)registerDeviceToken:( NSData * __nullable)deviceToken{
   NSString *_deviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
      stringByReplacingOccurrencesOfString: @">" withString: @""]
     stringByReplacingOccurrencesOfString: @" " withString: @""];
    [CTAppManager sharedInstance].apns_token = _deviceToken;
    [UMessage registerDeviceToken:deviceToken];
}

//iOS10以下使用这两个方法接收通知
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        [self didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

//iOS10新增：处理前台收到通知的代理方法
+ (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        //[self didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
+ (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [self didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }
}


+ (void)didReceiveRemoteNotification:(nullable NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
}


@end
