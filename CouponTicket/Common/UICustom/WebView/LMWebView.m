//
//  LMWebView.m
//  LightMaster
//
//  Created by Dankal on 2018/12/16.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import "LMWebView.h"

@interface LMWebView ()<UIWebViewDelegate>



@end

@implementation LMWebView

ViewInstance(setUp)

- (void)setUp{
    _webView = [[UIWebView alloc]init];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.opaque = 0;
    [self addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
//    @weakify(self)
//    [RACObserve(self.webView.scrollView,contentSize) subscribeNext:^(id  _Nullable x) {
//       @strongify(self)
//        CGFloat height = [x CGSizeValue].height;
//        if(height > 0){
//            [self mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(height);
//            }];
//            [self.superview layoutIfNeeded];
//        }
//        if(self.heightChangedBlock){
//            self.heightChangedBlock(height);
//        }
//    }];
}

- (void)setUrl:(NSString *)url{
    _url = url;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

- (void)setHtmlString:(NSString *)htmlString{
    _htmlString = htmlString;
    [_webView loadHTMLString:_htmlString baseURL:nil];
}

@end
