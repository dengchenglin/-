//
//  CTJdpGoodsItem.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTJdpGoodsItem.h"

@implementation CTJdpGoodsItem


- (void)awakeFromNib{
    [super awakeFromNib];
    _goodImageView.layer.borderColor = RGBColor(240, 240, 240).CGColor;
    _goodImageView.layer.borderWidth = LINE_WIDTH;
}

- (void)setModel:(CTGoodsModel *)model{
    _model = model;
    
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_logo] placeholderImage:CTGoodsFailImage];
    [_shopLogo sd_setImageWithURL:[NSURL URLWithString:_model.type_logo]];
    _titleLabel.text = [NSString stringWithFormat:@"%@",_model.goods_title];
    _couponLabel.text = [NSString stringWithFormat:@"%@元券",_model.coupon_amount];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.coupon_price];
    _originLabel.text = [NSString stringWithFormat:@"¥%@",_model.sale_price];
    _couponView.hidden = !_model.show_coupon;
}

@end
