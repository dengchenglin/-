//
//  CTThirtyTrendView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTThirtyTrendView.h"

@interface CTThirtyTrendView()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end

@implementation CTThirtyTrendView

ViewInstance(setUp)

- (void)setUp{
    @weakify(self)
    [RACObserve(self.webView.scrollView, contentSize) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        CGFloat height = [x CGSizeValue].height;
        self.contentHeight.constant = height;
        if(self.heightDidChangeBlock){
            self.heightDidChangeBlock(height);
        }
    }];
}

- (void)setUrl:(NSString *)url{
    _url = url;
    self.contentHeight.constant = _url.length?1:0;
    [self.superview layoutIfNeeded];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

@end
