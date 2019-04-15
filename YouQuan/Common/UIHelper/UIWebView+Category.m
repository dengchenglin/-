//
//  UIWebView+Category.m
//  GeihuiWang
//
//  Created by dengchenglin on 2017/7/26.
//  Copyright © 2017年 qianmeng. All rights reserved.
//

#import "UIWebView+Category.h"

#import <objc/runtime.h>

#import <JavaScriptCore/JavaScriptCore.h>

@implementation UIWebView (Category)

- (void)stringByEvaluatingJavaScriptFromString:(NSString *)js jsFunction:(NSString *)jsFunction complited:(void(^)(NSString *jsStr))complited{
    if(js.length == 0)return;
    JSContext *jsContext = [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    jsContext[jsFunction] = ^() {
        NSArray *args = [JSContext currentArguments];
        JSValue *jsVal = [args objectAtIndex:0];
        NSString *jsStr = [jsVal toString];
        if(complited){
            complited(jsStr);
        }
    };
    [self stringByEvaluatingJavaScriptFromString:js];
}


- (void)webDidFinishComplited:(dispatch_block_t)complited{
    JSContext *jsContext = [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    jsContext[@"webViewDidFinishComplited"] = ^() {
        if(complited){
            complited();
        }
    };
    [self stringByEvaluatingJavaScriptFromString:@"if(document.readyState == 'complete'){webViewDidFinishComplited();}"
     @"else{document.onreadystatechange= function() {"
     @"if(document.readyState == 'complete'){"
     @"webViewDidFinishComplited();}}};"];
}



@end
