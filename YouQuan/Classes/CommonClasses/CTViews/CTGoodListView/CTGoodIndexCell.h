//
//  CTGoodIndexCell.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTGoodsViewModel.h"

#define CTGoodIndexVerticalCellHeight 100
#define CTGoodIndexHorizontalCellHeight 114
NS_ASSUME_NONNULL_BEGIN

@interface CTGoodIndexCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UIView *profitView;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@property (nonatomic, strong) CTGoodsModel *model;
@end

NS_ASSUME_NONNULL_END
