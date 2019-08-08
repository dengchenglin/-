//
//  CTGoodsDescView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJGoodsDescViewfj.h"

@implementation FJGoodsDescViewfj

- (void)awakeFromNib{
    [super awakeFromNib];
    _upgradeView.hidden = ![CTAppManager sharedInstance].showMember;
}

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    [_typeImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.type_logo]];
    _titleLabel.text = [NSString stringWithFormat:@"%@",_viewModel.model.goods_title];
    _disLabel1.text = [NSString stringWithFormat:@"省%@元",_viewModel.model.commission_money];
    _disLabel2.text = [NSString stringWithFormat:@"升级可省%@元",_viewModel.model.upgrade_money];
    _priceLabel.text = _viewModel.model.coupon_price;
    _originPriceLabel.text = _viewModel.model.sale_price;
    _shopTitleLabel.text = _viewModel.model.shop_title;
    _salesLabel.text = _viewModel.model.package_sale;
    _upgradeView.hidden = !_viewModel.model.upgrade_money.length;
    _salesView.hidden = !_viewModel.model.package_sale.length;
    if(_upgradeView.hidden){
        [self.commissionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(18);
            make.centerY.mas_equalTo(0);
        }];
    }
    else{
        [self.commissionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.upgradeView.mas_left).offset(-10);
            make.height.mas_equalTo(18);
            make.centerY.mas_equalTo(0);
        }];
    }
}


@end
