//
//  CTGoodListView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTGoodsViewModel.h"
@interface CTGoodListView_ : UIView
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *disLabel1;
@property (weak, nonatomic) IBOutlet UILabel *disLabel2;
@property (weak, nonatomic) IBOutlet UIView *upgradeView;
@property (weak, nonatomic) IBOutlet UIView *salesView;
@property (weak, nonatomic) IBOutlet UIButton *upgradeDescBtn;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@property (nonatomic, strong) CTGoodsModel *model;
@end
