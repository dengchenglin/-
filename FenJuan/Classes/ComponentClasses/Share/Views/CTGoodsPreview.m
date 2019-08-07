//
//  CTGoodsPreview.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsPreview.h"
#import "UIView+YYAdd.h"
#import <SGQRCode/SGQRCode.h>
@implementation CTGoodsPreview

- (void)setModel:(CTGoodsModel *)model{
    _model = model;

    _titleLabel.text = [NSString stringWithFormat:@"%@",_model.goods_title];
    _couponLabel.text = [NSString stringWithFormat:@"%@元券",_model.coupon_amount];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.coupon_price];
    _originPriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.sale_price];
    _couponView.hidden = !_model.show_coupon;
}

+ (void)createGoodsPreviewWithImages:(NSArray <UIImage *>*)images models:(NSArray <CTGoodsModel *> *)models completed:(void(^)(NSArray <UIImage *>* images))completed{
    NSMutableArray *views = [NSMutableArray array];
    UIView *containerView = [UIView new];
    for(int i = 0;i < images.count;i ++){
        CTGoodsPreview *view = NSMainBundleClass(CTGoodsPreview.class);
        view.model = [models safe_objectAtIndex:i];
        view.goodsImageView.image = images[i];
        view.qCodeImageView.image = [self qrCodeImageWithImg:[models safe_objectAtIndex:i].goods_logo model:[models safe_objectAtIndex:i]];
        [containerView insertSubview:view atIndex:0];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        [containerView layoutIfNeeded];
        [views addObject:view];
    }
    NSMutableArray *_images = [NSMutableArray array];
    dispatch_async(dispatch_get_main_queue(), ^{
        for(int i = 0;i < views.count;i ++){
            UIImage *image = [views[i] snapshotImage];
            [_images addObject:image];
        }
        if(completed){
            completed(_images);
        }
    });
}

+ (void)createGoodsPreviewWithImages:(NSArray <UIImage *>*)images imgs:(NSArray <NSString *>*)imgs model:(CTGoodsModel *)model completed:(void(^)(NSArray <UIImage *>* images))completed{
    NSMutableArray *views = [NSMutableArray array];
    UIView *containerView = [UIView new];
    for(int i = 0;i < images.count;i ++){
        CTGoodsPreview *view = NSMainBundleClass(CTGoodsPreview.class);
        view.model = model;
        view.goodsImageView.image = images[i];
        view.qCodeImageView.image = [self qrCodeImageWithImg:[imgs safe_objectAtIndex:i] model:model];
        [containerView insertSubview:view atIndex:0];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        [containerView layoutIfNeeded];
        [views addObject:view];
    }
    NSMutableArray *_images = [NSMutableArray array];
    dispatch_async(dispatch_get_main_queue(), ^{
        for(int i = 0;i < views.count;i ++){
            UIImage *image = [views[i] snapshotImage];
            [_images addObject:image];
        }
        if(completed){
            completed(_images);
        }
    });
}

+ (UIImage *)qrCodeImageWithImg:(NSString *)img model:(CTGoodsModel *)model{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"%@?",model.qr_create_url];
    if(model.tpwd.length){
        [string appendFormat:@"tpwd=%@&",model.tpwd];
    }
    if(model.goods_title.length){
        [string appendFormat:@"name=%@&",model.goods_title];
    }
    if(img.length){
        [string appendFormat:@"img=%@&",img];
    }
    if(model.coupon_price.length){
        [string appendFormat:@"coupon_price=%@&",model.coupon_price];
    }
    if(model.commission_money.length){
        [string appendFormat:@"commission_money=%@&",model.commission_money];
    }
    if(model.iv_code.length){
        [string appendFormat:@"iv_code=%@",model.iv_code];
    }
    return [SGQRCodeObtain generateQRCodeWithData:string size:200];
}

@end
