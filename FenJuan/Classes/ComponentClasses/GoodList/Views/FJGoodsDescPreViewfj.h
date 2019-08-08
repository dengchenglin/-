//
//  CTGoodsDescPreView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTGoodsViewModel.h"
@interface FJGoodsDescPreViewfj : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UIImageView *couponBackgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@end
