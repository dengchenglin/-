//
//  AliTradeWebViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "AliTradeWebViewController.h"

@interface AliTradeWebViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIButton *reloadButton;

@end

@implementation AliTradeWebViewController

- (UIButton *)backButton{
    if(!_backButton){
        _backButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.enabled = NO;
        [_backButton setBackgroundImage:[UIImage imageNamed:@"webBack"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *)closeButton{
    if(!_closeButton){
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.titleLabel.font = CTPsbFont(16);
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _closeButton;
}
- (UIButton *)reloadButton{
    if(!_reloadButton){
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.enabled = NO;
        [_reloadButton setBackgroundImage:[UIImage imageNamed:@"webReload"] forState:UIControlStateNormal];
    }
    return _reloadButton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
    }
    return self;
}
- (void)setUpUI{
    self.navigationBarStyle = CTNavigationBarRed;
    self.webView.scalesPageToFit = YES;
    self.webView.opaque = YES;
    [self.view addSubview:self.webView];
}

- (void)autoLayout{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

@end
