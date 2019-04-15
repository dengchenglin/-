//
//  CTTaoBaoAuthViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTTaoBaoAuthViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIWebView+Category.h"

#import "AliTradeManager.h"
#import "CTAlertHelper.h"

@interface CTTaoBaoAuthViewController()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKUserContentController *userContentController;

@property (nonatomic, copy) NSString *currentUrl;

@end

@implementation CTTaoBaoAuthViewController

+ (UIViewController *)tbAuthFromViewController:(UIViewController *)viewController url:(NSString *)url callback:(void (^)(id data))callback{
    CTTaoBaoAuthViewController *tbVc = [[CTTaoBaoAuthViewController alloc]init];
    tbVc.url = url;
    tbVc.callback = callback;
    [CTAlertHelper showTbauthAlertViewWithCallback:^(NSUInteger buttonIndex) {
        if(buttonIndex == 1){
            [viewController.navigationController pushViewController:tbVc animated:YES];
        }
    }];
  
    return tbVc;
}

- (WKWebView *)webView{
    if(!_webView){
        _userContentController = [[WKUserContentController alloc]init];
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        configuration.userContentController = _userContentController;
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.opaque = YES;
    }
    return _webView;
}

- (void)setUpUI{
    self.title = @"淘宝授权";
    self.navigationBarStyle = CTNavigationBarRed;
    [self.view addSubview:self.webView];
    [self registerMessage];
}

- (void)request{
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

- (void)registerMessage{
    [_userContentController addScriptMessageHandler:self name:@"objectcSelector"];
    [_userContentController addScriptMessageHandler:self name:@"closePage"];
}

- (void)removeMessage{
    [_userContentController removeScriptMessageHandlerForName:@"objectcSelector"];
    [_userContentController removeScriptMessageHandlerForName:@"closePage"];
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    self.currentUrl = navigationAction.request.URL.absoluteString;
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"%@", navigationAction.request.URL.absoluteString);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [NSTimer scheduledTimerWithTimeInterval:0.1 block:^(NSTimer *timer) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } repeats:NO];
    
    //设置标题
    __weak typeof(self) weakSelf = self;
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable htmlSoure, NSError * _Nullable error) {
        if(htmlSoure){
            weakSelf.title = htmlSoure;
        }
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if([message.name isEqualToString:@"objectcSelector"]){
        NSDictionary *data = [message.body jsonValueDecoded];
        NSString *result = data[@"status"];
        if(result.integerValue == 200){
            if(self.callback){
                self.callback(data);
            }
            [self close];
        }
        else{
            [CTAlertHelper showTbauthFailAlertViewWithTitle:data[@"info"] callback:^(NSUInteger buttonIndex) {
                if(buttonIndex == 0){
                    [self close];
                }
                else{
                    [AliTradeManager logOut];
                    [self request];
                }
            }];
        }
    }
    if([message.name isEqualToString:@"closePage"]){
        [self close];
    }
}


- (void)close{
    dispatch_async(dispatch_get_main_queue(), ^{
        [super back];
    });
}

- (void)back{
    if([self.currentUrl isEqualToString:_url]){
        [super back];
    }
    else{
        if([self.webView canGoBack]){
            [self.webView goBack];
        }
        else{
            [super back];
        }
    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    if(!parent){
        [self removeMessage];
    }
}
- (void)dealloc
{
    
}

@end
