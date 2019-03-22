//
//  CTGoodsDescView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsDescView.h"

@implementation CTGoodsDescView

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    [_typeImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.type_logo]];
    _titleLabel.text = [NSString stringWithFormat:@"%@",_viewModel.model.goods_title];
    _disLabel1.text = [NSString stringWithFormat:@"赚%@元",_viewModel.model.commission_money];
    _disLabel2.text = [NSString stringWithFormat:@"升级可赚%@元",_viewModel.model.upgrade_money];
    _priceLabel.text = _viewModel.model.coupon_price;
    _originPriceLabel.text = _viewModel.model.market_price;
    _shopTitleLabel.text = _viewModel.model.shop_title;
    
     _upgradeView.hidden = !_viewModel.model.upgrade_money.length;
}


@end
