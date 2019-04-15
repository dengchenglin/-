//
//  UIWebView+Category.h
//  GeihuiWang
//
//  Created by dengchenglin on 2017/7/26.
//  Copyright © 2017年 qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Category)

- (void)stringByEvaluatingJavaScriptFromString:(NSString *)js jsFunction:(NSString *)jsFunction complited:(void(^)(NSString *jsStr))complited;

- (void)webDidFinishComplited:(dispatch_block_t)complited;

@end
