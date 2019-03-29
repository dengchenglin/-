//
//  CLNetworkConfig.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/27.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "CLNetworkConfig.h"

inline void dispatch_async_main(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

@implementation CLNetworkRequestConfig

+ (CLNetworkRequestConfig *)config {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {

        _requestTimeoutInterval = CL_REQUEST_TIMEOUT;
        _httpMaximumConnectionsPerHost = MAX_HTTP_CONNECTION_PER_HOST;

    }
    return self;
}

@end

@implementation CLNetworkConfig

+ (CLNetworkConfig *)config {
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _request = [CLNetworkRequestConfig config];
        _cachePolicy = NSURLRequestUseProtocolCachePolicy;
        _URLCache = [NSURLCache sharedURLCache];
    }
    return self;
}

@end
