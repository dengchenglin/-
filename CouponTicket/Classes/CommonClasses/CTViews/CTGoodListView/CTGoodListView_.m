//
//  CTGoodListView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodListView_.h"

@interface CTGoodListView_()
@property (weak, nonatomic) IBOutlet UIImageView *couponBgView;


@end

@implementation CTGoodListView_

- (void)awakeFromNib{
    [super awakeFromNib];
    _couponBgView.image = [[UIImage imageNamed:@"pic_list_coupon_bg1"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 45)];
}

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.goods_logo] placeholderImage:CTGoodsFailImage];
    [_typeImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.type_logo]];
    _titleLabel.text = [NSString stringWithFormat:@"...  %@",_viewModel.model.goods_title];
    _disLabel1.text = [NSString stringWithFormat:@"赚%@元",_viewModel.model.commission_money];
    _upgradeView.hidden = !_viewModel.model.upgrade_money.length;
    _disLabel2.text = [NSString stringWithFormat:@"升级可赚%@元",_viewModel.model.upgrade_money];
    _priceLabel.text = _viewModel.model.sale_price;
    _originPriceLabel.text = _viewModel.model.market_price;
    _couponPriceLabel.text = _viewModel.model.coupon_amount;
    _statusImageView.hidden = !_viewModel.model.status;
    _statusImageView.image = [UIImage imageNamed:GetTypeImageStr(_viewModel.model.status)];
}

@end
