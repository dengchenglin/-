//
//  CTWebViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWebViewController.h"

#import <WebKit/WebKit.h>

@interface CTWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *htmlString;

@property (nonatomic, copy) NSString *url;

@end

@implementation CTWebViewController

+ (UIViewController *)showWebFromViewController:(UIViewController *)viewController url:(NSString *)url htmlString:(NSString *)htmlString isPush:(BOOL)isPush{
    CTWebViewController *web = [[CTWebViewController alloc]init];
    web.htmlString = htmlString;
    web.url = url;
    if(isPush){
        [viewController.navigationController pushViewController:web animated:YES];
    }
    else{
        CTNavigationController *nav = [[CTNavigationController alloc]initWithRootViewController:web];
        [viewController presentViewController:nav animated:YES completion:nil];
    }
    return web;
}

- (WKWebView *)webView{
    if(!_webView){
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (void)setUpUI{
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.webView];
}
- (void)reloadView{
    NSURL *URL = [NSURL URLWithString:_url];
    if(URL){
        [MBProgressHUD showMBProgressHudOnView:self.view];
        [_webView loadRequest:[NSURLRequest requestWithURL:URL]];
    }
    if(_htmlString){
        [MBProgressHUD showMBProgressHudOnView:self.view];
        [_webView loadHTMLString:_htmlString baseURL:nil];
    }
}


#pragma mark -WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
