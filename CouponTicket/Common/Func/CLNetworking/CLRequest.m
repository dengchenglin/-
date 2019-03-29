//
//  CLRequest.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/28.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "CLRequest.h"

#import "CLNetworkManager.h"

@interface CLRequest ()

@property (nonatomic, copy) NSString *baseUrl;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSDictionary *httpHeaderFields;

@property (nonatomic, copy) NSString *customUrl;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

@property (nonatomic, assign) BOOL useGlobalParams;

@property (nonatomic, copy) NSDictionary <NSString *,id>*params;

@property (nonatomic, copy) CLCallbackBlock callBack;

@property (nonatomic, copy) CLProgressBlock progressCallBack;

@end

@implementation CLRequest

+ (instancetype)request{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseUrl = [CLNetworkManager shareInstance].config.request.baseUrl;
        _timeoutInterval = CL_REQUEST_TIMEOUT;
        _useGlobalParams = YES;
    }
    return self;
}

- (NSString *)identifier{
    return [NSString stringWithFormat:@"%zu",self.hash];
}

- (__kindof CLRequest *(^)(NSString *baseUrl))setBaseUrl{
    CLRequest *(^block)(NSString *baseUrl) = ^CLRequest *(NSString *baseUrl){
        self.baseUrl = baseUrl;
        return self;
    };
    
    return block;
}

- (__kindof CLRequest *(^)(NSString *customUrl))setCustomUrl{
    return ^CLRequest*(NSString *customUrl){
        
        self.customUrl = customUrl;
        return self;
    };
}

- (__kindof CLRequest *(^)(NSString *path))setPath{
    return ^CLRequest *(NSString *path){
        self.path = path;
        return self;
    };
}

- (__kindof CLRequest *(^)(NSDictionary *httpHeaderFields))setHttpHeaderFields{
    return ^CLRequest *(NSDictionary *httpHeaderFields){
        self.httpHeaderFields = httpHeaderFields;
        return self;
    };
}

- (__kindof CLRequest *(^)(NSTimeInterval timeoutInterval))setTimeoutInterval{
    return ^CLRequest *(NSTimeInterval timeoutInterval){
        self.timeoutInterval = timeoutInterval;
        return self;
    };
}

- (__kindof CLRequest *(^)(NSTimeInterval cachePolicy))setCachePolicy{
    return ^CLRequest *(NSTimeInterval cachePolicy){
        self.cachePolicy = cachePolicy;
        return self;
    };
}

- (__kindof CLRequest *(^)(BOOL useGlobalParams))setUseGlobalParams{
    return ^CLRequest *(BOOL useGlobalParams){
        self.useGlobalParams = useGlobalParams;
        return self;
    };
}

- (__kindof CLRequest *(^)(NSDictionary<NSString *, id> *params))setParams{
    return ^CLRequest *(NSDictionary<NSString *, id> *params){
        self.params = params;
        return self;
    };
}

- (__kindof CLRequest *(^)(CLCallbackBlock callBack))setCallBack{
    return ^CLRequest *(CLCallbackBlock callBack){
        self.callBack = callBack;
        return self;
    };
}

- (__kindof CLRequest *(^)(CLProgressBlock progressCallBack))setProgressCallBack{
    return ^CLRequest *(CLProgressBlock progressCallBack){
        self.progressCallBack = progressCallBack;
        return self;
    };
}

- (void)start{
    [CLNetworkManager send:self];
}

- (void)cancel{
    [CLNetworkManager cancel:self];
}

- (void)resume{
    [CLNetworkManager resume:self];
}

- (void)pause{
    [CLNetworkManager pause:self];
}


@end
