//
//  ShareManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UMShare/UMShare.h>

@interface CTUMSocialUserInfoResponse:NSObject
@property (nonatomic, copy) NSString  *uid;
@property (nonatomic, copy) NSString  *openid;
@property (nonatomic, copy) NSString  *refreshToken;
@property (nonatomic, copy) NSDate    *expiration;
@property (nonatomic, copy) NSString  *accessToken;
@property (nonatomic, copy) NSString  *unionId;

@property (nonatomic, copy) NSString  *name;
@property (nonatomic, copy) NSString  *iconurl;
@property (nonatomic, copy) NSString  *unionGender;
@property (nonatomic, copy) NSString  *gender;
- (instancetype)initWithResponse:(UMSocialUserInfoResponse *)response;
@end

@interface UMShareManager : NSObject
+ (void)config;
// 支持所有iOS系统
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType completion:(void(^)(CTUMSocialUserInfoResponse *respone))completion;

//图片分享
+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType thumbImage:(UIImage *)image imageUrl:(NSString *)imageUrl;
@end
