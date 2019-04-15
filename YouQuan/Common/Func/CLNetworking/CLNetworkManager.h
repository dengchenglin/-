//
//  CLNetworkManager.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/27.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLNetworkConfig.h"

#import "CLRequest.h"

@interface CLNetworkManager : NSObject

@property (nonatomic, strong, readonly) CLNetworkConfig *config;

+ (instancetype)shareInstance;

+ (void)setupConfig:(void(^)(CLNetworkConfig *config))configBlock;

+ (void)send:(CLRequest *)request;

+ (void)cancel:(CLRequest *)request;

+ (void)resume:(CLRequest *)request;

+ (void)pause:(CLRequest *)request;

@end
