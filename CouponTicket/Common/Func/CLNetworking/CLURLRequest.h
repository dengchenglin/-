//
//  CLURLRequest.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/27.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLRequest.h"

@interface CLURLRequest : CLRequest

@property (nonatomic, assign, readonly) CLRequestMethodType requestMethod;

@property (nonatomic, copy, readonly) CLRequestConstructingBodyBlock constructingBodyBlock;

+ (instancetype)request;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (__kindof CLRequest *(^)(NSString *baseUrl))setBaseUrl;
//该customUrl会覆盖baseURL
- (CLURLRequest *(^)(NSString *customUrl))setCustomUrl;

- (CLURLRequest *(^)(NSString *path))setPath;

- (CLURLRequest *(^)(NSDictionary *httpHeaderFields))setHttpHeaderFields;

- (CLURLRequest *(^)(NSTimeInterval timeoutInterval))setTimeoutInterval;

- (CLURLRequest *(^)(NSTimeInterval cachePolicy))setCachePolicy;

- (CLURLRequest *(^)(BOOL useGlobalParams))setUseGlobalParams;

- (CLURLRequest *(^)(NSDictionary<NSString *, id> *params))setParams;

- (CLURLRequest *(^)(CLCallbackBlock callBack))setCallBack;

- (CLURLRequest *(^)(CLProgressBlock progressCallBack))setProgressCallBack;

- (CLURLRequest *(^)(CLRequestMethodType requestMethod))setMethod;

- (CLURLRequest *(^)(CLRequestConstructingBodyBlock constructingBodyBlock))setConstructingBodyBlock;
@end
