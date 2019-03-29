//
//  CLModuleService.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/26.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLModuleServiceProtocol <NSObject>

@optional

- (_Nonnull id)module;

- (UIViewController * _Nonnull)rootViewController;

- (Class)rootClass;

@end
