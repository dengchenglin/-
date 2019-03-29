//
//  CLModuleManager.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/26.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "CLModuleManager.h"
#import "CLModuleServiceProtocol.h"


@interface CLModuleManager ()

@property (nonatomic, strong)NSMutableDictionary *moduleServices;

@end

@implementation CLModuleManager{
    NSLock *_moduleServiceLock;
}

- (NSMutableDictionary *)moduleServices{
    if(!_moduleServices){
        _moduleServices = [NSMutableDictionary dictionary];
    }
    return _moduleServices;
}

+ (instancetype)shareInstance{
    static CLModuleManager *moduleManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        moduleManager = [[CLModuleManager alloc]init];
    });
    return moduleManager;
}

+ (void)registerModuleServiceForClass:(Class)moduleServiceClass protocol:(Protocol *)moduleServiceProtocol{
    [[CLModuleManager shareInstance]registerModuleServiceForClass:moduleServiceClass protocol:moduleServiceProtocol];
}


+ (id<CLModuleServiceProtocol>)moduleServiceInstanceForProtocol:(Protocol *)moduleServiceProtocol{
    return [[CLModuleManager shareInstance]moduleServiceInstanceForProtocol:moduleServiceProtocol];
}

- (id<CLModuleServiceProtocol>)moduleServiceInstanceForProtocol:(Protocol *)moduleServiceProtocol{
    if(!moduleServiceProtocol)return nil;
    NSString *moduleServiceProtocolName = NSStringFromProtocol(moduleServiceProtocol);
    id service = self.moduleServices[moduleServiceProtocolName];
    if(!service){
        NSLog(@"%@",[NSString stringWithFormat:@"%@ does not been registed", moduleServiceProtocolName]);
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:nil userInfo:nil];
    }
    return service;
}


- (void)registerModuleServiceForClass:(Class)moduleServiceClass protocol:(Protocol *)moduleServiceProtocol{
    if(!moduleServiceProtocol || !moduleServiceClass)return;
    NSString *moduleServiceProtocolName = NSStringFromProtocol(moduleServiceProtocol);
    if(!self.moduleServices[moduleServiceProtocolName]){
        [_moduleServiceLock lock];
        id service = [[moduleServiceClass alloc]init];
        [self.moduleServices setValue:service forKey:moduleServiceProtocolName];
        [_moduleServiceLock unlock];
        return;
    }
    NSLog(@"waring: %@",[NSString stringWithFormat:@"%@ already been registed. each module should ideally correspond to only one service.", moduleServiceProtocolName]);
}

@end
