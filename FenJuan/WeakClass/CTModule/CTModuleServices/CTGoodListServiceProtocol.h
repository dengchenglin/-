//
//  CTGoodListServiceProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol CTGoodListServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)fj_goodListViewControllerWithCategoryId:(NSString *)categoryId;

- (UIViewController *)fj_goodListViewControllerWithActivityId:(NSString *)activityId;

- (UIViewController *)fj_goodDetailViewControllerWithGoodId:(NSString *)goodId;

- (UIViewController *)fj_goodDetailViewControllerWithGoodViewModel:(id)viewModel;

- (UIViewController *)hotsalesViewController;

- (UIViewController *)nineListViewController;

- (UIViewController *)handpickShopViewController;

- (UIViewController *)spreeShopViewController;

- (UIViewController *)videoShopViewController;

@end
