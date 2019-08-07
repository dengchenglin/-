//
//  CTGoodDetailViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

#import "CTGoodsViewModel.h"

@interface FJGoodDetailViewControllerfj : CTBaseViewController

@property (nonatomic, copy) NSString *goog_id;

@property (nonatomic, strong) CTGoodsViewModel *viewModel;

@end
