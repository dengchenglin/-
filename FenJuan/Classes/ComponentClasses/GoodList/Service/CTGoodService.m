//
//  CTGoodService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodService.h"

#import "FJGoodListViewControllerfj.h"

#import "FJGoodDetailViewControllerfj.h"

#import "CTNineNineListViewController.h"

#import "CTHandpickListViewController.h"

#import "CThotSalesListViewController.h"

#import "CTSpreeShopPageController.h"

#import "CTVideoShopPageController.h"

@implementation CTGoodService

CL_EXPORT_MODULE(CTGoodListServiceProtocol)

- (UIViewController *)goodListViewControllerWithCategoryId:(NSString *)categoryId{
    FJGoodListViewControllerfj *vc = [FJGoodListViewControllerfj new];
    vc.category_id = categoryId;
    return vc;
}

- (UIViewController *)goodListViewControllerWithActivityId:(NSString *)activityId{
    FJGoodListViewControllerfj *vc = [FJGoodListViewControllerfj new];
    vc.activity_id = activityId;
    return vc;
}

- (UIViewController *)goodDetailViewControllerWithGoodId:(NSString *)goodId{
    FJGoodDetailViewControllerfj * vc = [FJGoodDetailViewControllerfj new];
    vc.goog_id = goodId;
    return vc;
}
- (UIViewController *)goodDetailViewControllerWithGoodViewModel:(id)viewModel{
    FJGoodDetailViewControllerfj * vc = [FJGoodDetailViewControllerfj new];
    vc.viewModel = viewModel;
    return vc;
}

- (UIViewController *)hotsalesViewController{
    return [CThotSalesListViewController new];
}

- (UIViewController *)nineListViewController{
    return [CTNineNineListViewController new];
}

- (UIViewController *)handpickShopViewController{
    return [CTHandpickListViewController new];
}

- (UIViewController *)spreeShopViewController{
    return [CTSpreeShopPageController new];
}

- (UIViewController *)videoShopViewController{
    return [CTVideoShopPageController new];
}

@end
