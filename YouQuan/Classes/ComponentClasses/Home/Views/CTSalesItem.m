//
//  CTSalesItem.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSalesItem.h"

@implementation CTSalesItem

- (void)setModel:(CTGoodsModel *)model{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_logo] placeholderImage:CTGoodsFailImage];
    _titleLabel.text = _model.goods_short_title;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.sale_price];
}

@end
