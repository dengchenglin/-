//
//  CLModuleManager.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/26.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLModuleManager : NSObject

+ (instancetype)shareInstance;

+ (void)registerModuleServiceForClass:(Class)moduleServiceClass protocol:(Protocol *)moduleServiceProtocol;

+ (Class)moduleServiceForProtocol:(Protocol *)moduleServiceProtocol;

+ (id)moduleServiceInstanceForProtocol:(Protocol *)moduleServiceProtocol;


@end
