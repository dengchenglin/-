//
//  CTHandpickDescView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHandpickDescViewfj.h"

@implementation FJHandpickDescViewfj

- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 33;

    
    @weakify(self)
    [self.webView setHeightChangedBlock:^(CGFloat height) {
        @strongify(self)
        self.webViewHeight.constant = height;
        [self.superview layoutIfNeeded];
        if(self.heightChangedBlock){
            self.heightChangedBlock(height);
        }
    }];
}

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    _titleLabel.text = _viewModel.model.title;
    _dateLabel.text = _viewModel.model.create_at;
    _webView.htmlString = _viewModel.model.detail;
    if(_webView.htmlString.length){
        _webViewHeight.constant = 1;
    }
    else{
        _webViewHeight.constant = 0;
    }
    [self.superview layoutIfNeeded];
    _webView.htmlString = _viewModel.model.detail;
    if(self.heightChangedBlock){
        self.heightChangedBlock(0);
    }
}

@end
