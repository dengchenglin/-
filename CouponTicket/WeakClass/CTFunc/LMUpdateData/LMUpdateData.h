//
//  LMUpdateData.h
//  LightMaster
//
//  Created by Dankal on 2019/1/5.
//  Copyright © 2019 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LMImageUrlForKey(key) [@"http://lighting.dankal.cn/" stringByAppendingPathComponent:key]

@interface LMUpdateData : NSObject

+ (void)updateImages:(NSArray <UIImage *>*)images callback:(void(^)(NSArray <NSString *> *hashKeys))callback;

+ (void)updateImages:(NSArray <UIImage *>*)images keys:(NSArray <NSString *>*)keys callback:(void(^)(NSArray <NSString *> *hashKeys))callback;

@end
