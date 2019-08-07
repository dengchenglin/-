//
//  CLNetworkManager.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/27.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "CLNetworkManager.h"

#import "CLNetworkDefines.h"

#import "CLNetworkEngine.h"

@interface  CLNetworkManager ()

@property (nonatomic, strong) CLNetworkConfig *config;

@end

@implementation CLNetworkManager

+ (instancetype)shareInstance {
    static CLNetworkManager *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[self alloc] init];
        
    });
    return networkManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _config = [CLNetworkConfig config];
    }
    return self;
}

+ (void)setupConfig:(void(^)(CLNetworkConfig *config))configBlock{
    [[self shareInstance] setupConfig:configBlock];
}

+ (void)send:(CLRequest *)request{
    [[self shareInstance]send:request];
}

+ (void)cancel:(CLRequest *)request{
    [[self shareInstance]cancel:request];
}

+ (void)resume:(CLRequest *)request{
    [[self shareInstance] resume:request];
}

+ (void)pause:(CLRequest *)request{
    [[self shareInstance] pause:request];
}

- (void)setupConfig:(void (^)(CLNetworkConfig * _Nonnull config))configBlock {
    CL_NETWORK_SAFE_BLOCK(configBlock, self.config);
}

- (void)send:(CLRequest *)request{

    [[CLNetworkEngine sharedEngine]sendRequest:request config:self.config progressCallBack:request.progressCallBack callBack:request.callBack];
}

- (void)cancel:(CLRequest *)request{
    [[CLNetworkEngine sharedEngine]cancelRequest:request];
}

- (void)resume:(CLRequest *)request{
    [[CLNetworkEngine sharedEngine]resumeRequest:request];
}

- (void)pause:(CLRequest *)request{
    [[CLNetworkEngine sharedEngine]pauseRequest:request];
}

@end
