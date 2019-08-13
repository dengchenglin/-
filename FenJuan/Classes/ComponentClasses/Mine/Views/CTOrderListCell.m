//
//  CTOrderListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTOrderListCell.h"

@implementation CTOrderListCell

- (void)setViewModel:(FJOrderViewModelfj *)viewModel{
    _viewModel = viewModel;
    _orderLabel.text = _viewModel.model.trade_id;
    _mobileLabel.text = _viewModel.model.phone;
    _statusLabel.text = _viewModel.model.tk_status_txt;
    _goodTitleLabel.text = _viewModel.model.item_title;
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.item_img]];
    _createTimeLabel.text = _viewModel.model.create_time;
    _priceLabel.text  = [NSString stringWithFormat:@"¥%@",_viewModel.model.alipay_total_price];
    _rebateDescLabel.text = [NSString stringWithFormat:@"返利%@元",_viewModel.model.money];
    [_userheadImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.headimg]];
    _rebateDescLabel.hidden = !_viewModel.model.money.length;
}

@end
