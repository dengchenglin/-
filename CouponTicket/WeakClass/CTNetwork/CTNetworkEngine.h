//
//  CTNetworkEngine.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLNetworking.h"

#define CT_API_DEVELOPER_BASE_URL @"http://test.youquan8888888.com"

#define CT_API_PRODUCTION_BASE_URL @"http://www.youquan8888888.com"

#ifdef DEBUG
#define CT_API_BASE_URL  CT_API_DEVELOPER_BASE_URL
#else
#define CT_API_BASE_URL  CT_API_PRODUCTION_BASE_URL
#endif

#define CTBaseUrl(path) [CT_API_BASE_URL stringByAppendingPathComponent:path]

#define CTUrlPath(path) [@"api" stringByAppendingPathComponent:path]

#define CTRequest [CTNetworkEngine sharedInstance]

typedef NS_ENUM(NSInteger,CTNetError) {
    CTNetErrorNone = 0, //请求成功
    CTNetErrorNet ,     //网络或服务器错误
    CTNetErrorStatus,   //请求状态出错，一般是参数出错
    CTNetErrorData,     //数据解析失败
    CTNetErrorTimeOut   //请求超时
};


typedef void(^CTResponseBlock) (id data,CLRequest *request,CTNetError error);


@interface CTNetworkEngine : NSObject

+ (instancetype)sharedInstance;

+ (NSString *)baseUrl;

- (CLRequest *)getWithPath:(NSString *)path params:(NSDictionary *)params callback:(CTResponseBlock)callback;

- (CLRequest *)getWithPath:(NSString *)path params:(NSDictionary *)params showHud:(BOOL)showHud callback:(CTResponseBlock)callback;


- (CLRequest *)postWithPath:(NSString *)path params:(NSDictionary *)params callback:(CTResponseBlock)callback;

- (CLRequest *)postWithPath:(NSString *)path params:(NSDictionary *)params showHud:(BOOL)showHud callback:(CTResponseBlock)callback;

- (CLRequest *)postWithPath:(NSString *)path params:(NSDictionary *)params images:(NSArray <UIImage *>*)images showHud:(BOOL)showHud callback:(CTResponseBlock)callback;

- (CLRequest *)postWithPath:(NSString *)path params:(NSDictionary *)params showHud:(BOOL)showHud showErrorHud:(BOOL)showErrorHud callback:(CTResponseBlock)callback;

- (CLRequest *)requestWithMethod:(CLRequestMethodType)methodType path:(NSString *)path params:(NSDictionary *)params images:(NSArray <UIImage *>*)images showHud:(BOOL)showHud callback:(CTResponseBlock)callback;

@end
