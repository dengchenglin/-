//
//  CTTaoBaoAuthViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTTaoBaoAuthViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import "UIWebView+Category.h"

@interface CTTaoBaoAuthViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CTTaoBaoAuthViewController

- (UIWebView *)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _webView.opaque = YES;
    }
    return _webView;
}

- (void)setUpUI{
    self.title = @"淘宝授权";
    self.navigationBarStyle = CTNavigationBarRed;
     [self.view addSubview:self.webView];
}
- (void)reloadView{
    if(_url){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud hideAnimated:YES afterDelay:5.0];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }

}

- (void)autoLayout{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",request.URL.absoluteString);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [NSTimer scheduledTimerWithTimeInterval:0.1 block:^(NSTimer *timer) {
          [MBProgressHUD hideHUDForView:self.view animated:YES];
    } repeats:NO];
  
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if(title){
        self.title = title;
    }
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"objectcSelector"] = ^(){
        NSArray *args = [JSContext currentArguments];
        JSValue *jsVal = [args objectAtIndex:0];
        NSString *jsStr = [jsVal toString];
        NSDictionary *data = [jsStr jsonValueDecoded];
        NSString *result = data[@"status"];
        if(result.integerValue == 200){
            if(self.callback){
                self.callback(data);
            }
        }
        else{
            [UIAlertView showMessage:data[@"info"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self back];
        });
    };
    context[@"closePage"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self back];
        });
    };

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
