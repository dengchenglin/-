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
    self.model = _viewModel.model;
}

- (void)setModel:(CTGoodsModel *)model{
    _model = model;
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_logo] placeholderImage:CTGoodsFailImage];
    [_typeImageView sd_setImageWithURL:[NSURL URLWithString:_model.type_logo]];
    _titleLabel.text = [NSString stringWithFormat:@"...  %@",_model.goods_title];
    _disLabel1.text = [NSString stringWithFormat:@"返%@元",_model.commission_money];
    
    _disLabel2.text = [NSString stringWithFormat:@"升级可返%@元",_model.upgrade_money];
    _priceLabel.text = _model.coupon_price;
    _originPriceLabel.text = _model.sale_price;
    _couponPriceLabel.text = _model.coupon_amount;
    _salesLabel.text = _model.package_sale;
    
    _statusImageView.image = [UIImage imageNamed:GetTypeImageStr(_model.status)];
    _upgradeView.hidden = !_model.upgrade_money.length;
    _statusImageView.hidden = !_model.status;
    _salesView.hidden = !_model.package_sale.length;
    _couponView.hidden = !_model.show_coupon;
}

@end
