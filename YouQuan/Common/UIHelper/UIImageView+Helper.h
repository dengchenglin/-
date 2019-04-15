//
//  UIImageView+Helper.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/10/19.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Helper)

- (void)addActionWithBlock:(void(^)(id target))block;

- (void)cl_setImageWithImg:(id)img;

@end

NS_ASSUME_NONNULL_END
