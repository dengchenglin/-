//
//  CTGoodsContentView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsContentView.h"

@interface CTGoodsContentView()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end
@implementation CTGoodsContentView

ViewInstance(setUp)

- (void)setUp{
    self.contentView.scalesPageToFit = YES;
    self.contentView.scrollView.showsVerticalScrollIndicator = NO;
    @weakify(self)
    [RACObserve(self.contentView.scrollView, contentSize) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if(!_htmlString.length && _url.length){
            return ;
        }
        CGFloat contentHeight = [x CGSizeValue].height;
        if(contentHeight > SCREEN_HEIGHT - TABBAR_HEIGHT){
            contentHeight = SCREEN_HEIGHT - TABBAR_HEIGHT;
        }
        self.contentHeight.constant = contentHeight;
        [self layoutIfNeeded];
        if(self.heightChangeBlock){
            self.heightChangeBlock(self.contentHeight.constant + self.titleHeight.constant);
        }
    }];
}


- (void)setHtmlString:(NSString *)htmlString{
    _htmlString = htmlString;
    if(_htmlString.length){
        self.contentHeight.constant = 1;
        self.titleHeight.constant = 45;
    }
    else{
        self.titleHeight.constant = 0;
        self.contentHeight.constant = 0;
    }
    [self.superview layoutIfNeeded];
    
    [self.contentView loadHTMLString:_htmlString baseURL:nil];
    if(_heightChangeBlock){
        _heightChangeBlock(self.contentHeight.constant + self.titleHeight.constant);
    }
}
- (void)setUrl:(NSString *)url{
    _url = url;
    if(_url.length){
        self.contentHeight.constant = SCREEN_HEIGHT - TABBAR_HEIGHT;
        self.titleHeight.constant = 45;
    }
    else{
        self.titleHeight.constant = 0;
        self.contentHeight.constant = 0;
    }
    [self.superview layoutIfNeeded];
    [self.contentView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    if(_heightChangeBlock){
        _heightChangeBlock(self.contentHeight.constant + self.titleHeight.constant);
    }
}
- (void)dealloc
{
    
}
@end
