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

#import "FJNineNineListViewControllerfj.h"

#import "FJHandpickListViewControllerfj.h"

#import "FJHotSalesListViewControllerfj.h"

#import "FJSpreeShopPageControllerfj.h"

#import "FJVideoShopPageControllerfj.h"

@implementation CTGoodService

CL_EXPORT_MODULE(CTGoodListServiceProtocol)

- (UIViewController *)fj_goodListViewControllerWithCategoryId:(NSString *)categoryId{
    FJGoodListViewControllerfj *vc = [FJGoodListViewControllerfj new];
    vc.category_id = categoryId;
    return vc;
}

- (UIViewController *)fj_goodListViewControllerWithActivityId:(NSString *)activityId{
    FJGoodListViewControllerfj *vc = [FJGoodListViewControllerfj new];
    vc.activity_id = activityId;
    return vc;
}

- (UIViewController *)fj_goodDetailViewControllerWithGoodId:(NSString *)goodId{
    FJGoodDetailViewControllerfj * vc = [FJGoodDetailViewControllerfj new];
    vc.goog_id = goodId;
    return vc;
}
- (UIViewController *)fj_goodDetailViewControllerWithGoodViewModel:(id)viewModel{
    FJGoodDetailViewControllerfj * vc = [FJGoodDetailViewControllerfj new];
    vc.viewModel = viewModel;
    return vc;
}

- (UIViewController *)hotsalesViewController{
    return [FJHotSalesListViewControllerfj new];
}

- (UIViewController *)nineListViewController{
    return [FJNineNineListViewControllerfj new];
}

- (UIViewController *)handpickShopViewController{
    return [FJHandpickListViewControllerfj new];
}

- (UIViewController *)spreeShopViewController{
    return [FJSpreeShopPageControllerfj new];
}

- (UIViewController *)videoShopViewController{
    return [FJVideoShopPageControllerfj new];
}

@end
