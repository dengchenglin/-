//
//  CTGoodsPreViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

#import "CTGoodsViewModel.h"

@interface FJGoodsPreViewControllerfj : CTBaseViewController

+ (FJGoodsPreViewControllerfj *)pushGoodPreFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel qCodeContent:(NSString *)qCodeContent;

@end
