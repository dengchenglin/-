//
//  CLNetworkConfig.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/27.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLNetworkConst.h"

NS_ASSUME_NONNULL_BEGIN


#define CL_REQUEST_TIMEOUT   20         // 默认的请求超时时间
#define MAX_HTTP_CONNECTION_PER_HOST 5  // Host链接次数

DISPATCH_EXPORT void dispatch_async_main(dispatch_block_t block);

@interface CLNetworkRequestConfig : NSObject

@property (nonatomic, copy, nullable) NSString *baseUrl;

@property (nonatomic, assign) NSInteger httpMaximumConnectionsPerHost;

// 请求超时时间，默认为20秒
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;

// 是否开启网络debug日志
@property (nonatomic, assign) BOOL enableNetworkLog;

+ (nonnull CLNetworkRequestConfig *)config;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

@end


@interface CLNetworkConfig : NSObject

@property (nonatomic, strong) CLNetworkRequestConfig *request;

@property (nonatomic, assign) CLRequestSerializerType requestSerializerType;

@property (nonatomic, assign) CLResponseSerializerType responseSerializerType;

@property (nonatomic,   copy) NSSet *accpetContentTypes;

@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

@property (nonatomic, assign) NSURLCache *URLCache;

@property (nonatomic,   copy) NSDictionary<NSString*,id> *globalParams;

+ (CLNetworkConfig *)config;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
