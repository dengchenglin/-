//
//  AliTradeManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AlibabaAuthSDK/ALBBSession.h>
@interface AliTradeManager : UIView

+ (void)initSDK;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;


+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options;

+ (void)openTbWithViewController:(UIViewController *)viewController url:(NSString *)url;


+ (BOOL)isLogin;

+(void)logOut;

+ (BOOL)isInstallTb;

+ (void)autoWithViewController:(UIViewController *)viewController successCallback:(void(^)(ALBBSession *session))successCallback;
@end
