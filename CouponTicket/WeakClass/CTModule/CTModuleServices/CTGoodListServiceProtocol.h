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

- (UIViewController *)goodListViewControllerWithCategoryId:(NSString *)categoryId;

- (UIViewController *)goodListViewControllerWithActivityId:(NSString *)activityId;

- (UIViewController *)goodDetailViewControllerWithGoodId:(NSString *)goodId;

- (UIViewController *)hotsalesViewController;

- (UIViewController *)nineListViewController;

- (UIViewController *)handpickShopViewController;

- (UIViewController *)spreeShopViewController;

- (UIViewController *)videoShopViewController;

@end
