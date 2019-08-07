//
//  CTGoodListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodListCell.h"

@implementation CTGoodListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _containerView = NSMainBundleClass(CTGoodListView_.class);
    [self.contentView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
    }];
}

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    _containerView.viewModel = _viewModel;
}
- (void)setModel:(CTGoodsModel *)model{
    _model = model;
    _containerView.model = model;
}

@end
