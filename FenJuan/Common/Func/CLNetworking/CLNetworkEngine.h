//
//  HLNetworkEngine.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/28.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLNetworkConst.h"

@class CLRequest;
@class CLNetworkConfig;

@interface CLNetworkEngine : NSObject

+ (_Nonnull instancetype)sharedEngine;

+ (_Nonnull instancetype)new NS_UNAVAILABLE;
- (_Nonnull instancetype)init NS_UNAVAILABLE;


- (void)sendRequest:(__kindof CLRequest * _Nonnull)request
             config:(CLNetworkConfig * _Nonnull)config
   progressCallBack:(CLProgressBlock _Nullable)progressCallBack
           callBack:(CLCallbackBlock _Nullable)callBack;

- (void)cancelRequest:(CLRequest *)request;

- (void)resumeRequest:(CLRequest *)request;

- (void)pauseRequest:(CLRequest *)request;

@end
