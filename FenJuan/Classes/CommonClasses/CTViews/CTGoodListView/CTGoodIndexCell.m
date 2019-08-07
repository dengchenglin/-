//
//  CTGoodIndexCell.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodIndexCell.h"

@implementation CTGoodIndexCell

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    self.model = _viewModel.model;
}
- (void)setModel:(CTGoodsModel *)model{
    _model = model;
    
    __weak typeof(self) weakSelf = self;
    
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_logo] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(!image){
            weakSelf.goodImageView.image = CTGoodsFailImage;
        }
        if(!model.imgAnimated){
            weakSelf.goodImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                weakSelf.goodImageView.alpha = 1.0;
            }];
            model.imgAnimated = YES;
        }
    }];
    [_shopLogo sd_setImageWithURL:[NSURL URLWithString:_model.type_logo]];
    _titleLabel.text = [NSString stringWithFormat:@"...  %@",_model.goods_title];
    _couponLabel.text = [NSString stringWithFormat:@"%@元券",_model.coupon_amount];
    
    _profitLabel.text = [NSString stringWithFormat:@"预估可省%@元",_model.commission_money];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.coupon_price];
    _originLabel.text = [NSString stringWithFormat:@"¥%@",_model.sale_price];

    _salesLabel.text = [NSString stringWithFormat:@"月售%@件",_model.package_sale];
    _storeNameLabel.text = _model.shop_title;
    _couponView.hidden = !_model.show_coupon;
    if(_couponLabel.hidden){
        [_profitView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(18);
            make.centerY.mas_equalTo(self.couponView.mas_centerY);
        }];
    }
    else{
        [_profitView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.couponView.mas_right).offset(5);
            make.height.mas_equalTo(18);
            make.centerY.mas_equalTo(self.couponView.mas_centerY);
        }];
    }
    
   
}
@end
