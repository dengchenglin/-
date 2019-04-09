//
//  CTSevenTrendView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSevenTrendView.h"

@interface CTSevenTrendView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trendHeight;

@end

@implementation CTSevenTrendView

ViewInstance(setUp)

- (void)setUp{
    _trendView.backgroundColor = [UIColor whiteColor];
    _trendView.scalesPageToFit = YES;
    _trendView.scrollView.showsVerticalScrollIndicator = NO;
    _trendView.scrollView.showsHorizontalScrollIndicator = NO;
    _headHeight.constant = 0;
    @weakify(self)
    [RACObserve(self.trendView.scrollView, contentSize) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if(self.url.length){
            CGFloat height = [x CGSizeValue].height;
            self.trendHeight.constant = height;
            if(self.heightDidChangeBlock){
                self.heightDidChangeBlock(height + 60);
            }
        }
    }];
}
- (void)setUrl:(NSString *)url{
    _url = url;
    if(_url.length){
        _trendHeight.constant = 1;
        _headHeight.constant = 60;
    }
    else{
        _trendHeight.constant = 0;
        _headHeight.constant = 0;
    }
    [self.superview layoutIfNeeded];
    [_trendView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    if(self.heightDidChangeBlock){
        self.heightDidChangeBlock(_headHeight.constant);
    }
}

@end
