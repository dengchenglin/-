//
//  CTJdpGoodsItem.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define CTJdpListItemSize CGSizeMake((SCREEN_WIDTH - 46)/3,((SCREEN_WIDTH - 46)/3 + 92)) 

@interface CTJdpGoodsItem : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (nonatomic, strong) CTGoodsModel *model;
@end

NS_ASSUME_NONNULL_END
