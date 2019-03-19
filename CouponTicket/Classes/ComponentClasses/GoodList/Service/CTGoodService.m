//
//  CTGoodService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodService.h"

#import "CTGoodListViewController.h"

#import "CTGoodDetailViewController.h"

#import "CTNineNineListViewController.h"

#import "CTHandpickListViewController.h"

#import "CThotSalesListViewController.h"

#import "CTSpreeShopPageController.h"

#import "CTVideoShopPageController.h"

@implementation CTGoodService

CL_EXPORT_MODULE(CTGoodListServiceProtocol)

- (UIViewController *)goodListViewControllerWithCategoryId:(NSString *)categoryId{
    CTGoodListViewController *vc = [CTGoodListViewController new];
    vc.category_id = categoryId;
    return vc;
}

- (UIViewController *)goodListViewControllerWithActivityId:(NSString *)activityId{
    CTGoodListViewController *vc = [CTGoodListViewController new];
    vc.activity_id = activityId;
    return vc;
}

- (UIViewController *)goodDetailViewControllerWithGoodId:(NSString *)goodId{
    CTGoodDetailViewController * vc = [CTGoodDetailViewController new];
    vc.goog_id = goodId;
    return vc;
}
- (UIViewController *)goodDetailViewControllerWithGoodViewModel:(id)viewModel{
    CTGoodDetailViewController * vc = [CTGoodDetailViewController new];
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
