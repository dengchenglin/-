//
//  UIActionSheet+Category.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/9/20.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Category)

- (void)setBlock:(void(^)(NSUInteger buttonIndex))block;

@end
