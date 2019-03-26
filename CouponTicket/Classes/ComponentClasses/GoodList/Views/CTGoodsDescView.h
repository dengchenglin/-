//
//  CTGoodsDescView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTGoodsViewModel.h"
@interface CTGoodsDescView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *disLabel1;
@property (weak, nonatomic) IBOutlet UIView *commissionView;
@property (weak, nonatomic) IBOutlet UILabel *disLabel2;
@property (weak, nonatomic) IBOutlet UIView *upgradeView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@end
