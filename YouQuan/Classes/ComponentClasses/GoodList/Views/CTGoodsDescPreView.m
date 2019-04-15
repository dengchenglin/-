//
//  CTGoodsDescPreView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsDescPreView.h"

@implementation CTGoodsDescPreView
- (void)awakeFromNib{
    [super awakeFromNib];
    _couponBackgroundImageView.image = [[UIImage imageNamed:@"pic_coupon_2"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 50)];
}
- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
     _titleLabel.text = [NSString stringWithFormat:@"%@",_viewModel.model.goods_title];
    _priceLabel.text = _viewModel.model.coupon_price;
    _originPriceLabel.text = _viewModel.model.market_price;
    _couponLabel.text = _viewModel.model.coupon_text;
    _couponView.hidden = !_viewModel.model.coupon_text.length;
}
@end
