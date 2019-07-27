//
//  CTGoodsPreview.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface CTGoodsPreview : UIView
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qCodeImageView;
@property (nonatomic, strong) CTGoodsModel *model;

+ (void)createGoodsPreviewWithImages:(NSArray <UIImage *>*)images imgs:(NSArray <NSString *>*)imgs model:(CTGoodsModel *)model completed:(void(^)(NSArray <UIImage *>* images))completed;

+ (void)createGoodsPreviewWithImages:(NSArray <UIImage *>*)images models:(NSArray <CTGoodsModel *> *)models completed:(void(^)(NSArray <UIImage *>* images))completed;
@end

NS_ASSUME_NONNULL_END
