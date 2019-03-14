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
//    _couponBgView.image = [[UIImage imageNamed:@"pic_list_coupon_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 45)];
}

- (void)setModel:(CTGoodsModel *)model{
    _model = model;
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_logo] placeholderImage:CTGoodsFailImage];
    [_typeImageView sd_setImageWithURL:[NSURL URLWithString:_model.type_logo]];
    _titleLabel.text = [NSString stringWithFormat:@"...  %@",_model.goods_title];
    _disLabel1.text = [NSString stringWithFormat:@"赚%@元",_model.commission_money];
    _upgradeView.hidden = !_model.upgrade_money.length;
    _disLabel2.text = [NSString stringWithFormat:@"升级可赚%@元",_model.upgrade_money];
    _priceLabel.text = _model.sale_price;
    _originPriceLabel.text = _model.market_price;
    _couponPriceLabel.text = [NSString stringWithFormat:@"%.0f",_model.coupon_amount.floatValue];
}

@end
