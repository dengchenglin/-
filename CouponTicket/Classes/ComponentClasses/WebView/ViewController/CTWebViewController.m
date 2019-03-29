//
//  CTWebViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWebViewController.h"

@interface CTWebViewController ()<UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

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

- (UIWebView *)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)setUpUI{
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.webView];
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.delegate = self;
}
- (void)reloadView{
    NSURL *URL = [NSURL URLWithString:_url];
    if(URL){
        [MBProgressHUD showMBProgressHudOnView:self.view];
        [_webView loadRequest:[NSURLRequest requestWithURL:URL]];
        DBLog(@"url is %@",_url);
    }
    if(_htmlString){
        [MBProgressHUD showMBProgressHudOnView:self.view];
        [_webView loadHTMLString:_htmlString baseURL:nil];
        DBLog(@"htmlStr is %@",_htmlString);
    }
}


#pragma mark -WKNavigationDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}
@end
