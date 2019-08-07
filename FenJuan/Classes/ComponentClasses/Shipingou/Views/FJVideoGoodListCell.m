//
//  CTVideoGoodListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTVideoGoodListCell.h"
#import <JPVideoPlayer/UIView+WebVideoCache.h>
@implementation CTVideoGoodListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    @weakify(self)
    [self.playButton touchUpInsideSubscribeNext:^(UIButton *x) {
        @strongify(self)
        if(self.delegate && [self.delegate respondsToSelector:@selector(didClickVideoWithIndexPath:)]){
            [self.delegate didClickVideoWithIndexPath:self.indexPath];
        }
    }];
}

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    [_previewImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.goods_logo]];
    
    self.model = _viewModel.model;
}
- (void)setModel:(CTGoodsModel *)model{
    _model = model;
   
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_logo]];
    [_shopLogo sd_setImageWithURL:[NSURL URLWithString:_model.type_logo]];
    _titleLabel.text = [NSString stringWithFormat:@"...  %@",_model.goods_title];
    _couponLabel.text = [NSString stringWithFormat:@"%@元券",_model.coupon_amount];
    
    _profitLabel.text = [NSString stringWithFormat:@"预估可省%@元",_model.commission_money];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.coupon_price];
    _originLabel.text = [NSString stringWithFormat:@"¥%@",_model.sale_price];
    
    _salesLabel.text = [NSString stringWithFormat:@"月售%@件",_model.package_sale];
  
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


- (void)stopPlay{
    [self.playButton jp_stopPlay];
    self.playButton.selected = NO;
    if(self.playButton.jp_videoPlayerView.superview){
        [self.playButton.jp_videoPlayerView removeFromSuperview];
    }
}
- (void)removeVideoView{
    self.playButton.selected = NO;
    if(self.playButton.jp_videoPlayerView.superview){
        [self.playButton.jp_videoPlayerView removeFromSuperview];
    }
}
@end
