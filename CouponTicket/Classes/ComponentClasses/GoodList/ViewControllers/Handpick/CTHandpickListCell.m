
//
//  CTHandpickListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHandpickListCell.h"

@implementation CTHandpickListCell

- (void)awakeFromNib{
    [super awakeFromNib];
    dispatch_async(dispatch_get_main_queue(), ^{
        _photoViews.autoExtrusion = NO;
        _photoViews.isCanEdit = NO;
    });
}
- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    _titleLabel.text = _viewModel.model.title;
    _descLabel.text = _viewModel.model.remark;
    _dateLabel.text = _viewModel.model.create_at;
    dispatch_async(dispatch_get_main_queue(), ^{
        _photoViews.imgs = _viewModel.model.imgs;
    });    
}

@end
