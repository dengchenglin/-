//
//  CTModuleHelper+GoShop.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/26.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTModuleHelper.h"

#import "CTGoodsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTModuleHelper (GoShop)
//购物跳转
+ (void)goShopFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel;
//分享
+ (void)shareShopFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
