//
//  ShareUtil.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString * const CLShareWechat;
UIKIT_EXTERN NSString * const CLShareQQ;

@interface ShareUtil : NSObject
+ (void)shareWithImages:(NSArray <UIImage *>*)images type:(NSString *)type completed:(void(^)(void))completed;

@end
