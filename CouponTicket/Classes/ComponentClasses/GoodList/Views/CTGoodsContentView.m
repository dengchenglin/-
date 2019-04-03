//
//  CTGoodsContentView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsContentView.h"

@interface CTGoodsContentView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end
@implementation CTGoodsContentView

ViewInstance(setUp)

- (void)setUp{
    @weakify(self)
    [RACObserve(self.contentView.scrollView, contentSize) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        CGFloat contentHeight = [x CGSizeValue].height;
        self.contentHeight.constant = contentHeight;
        [self layoutIfNeeded];
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
}

@end
