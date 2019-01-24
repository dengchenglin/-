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

#import "CThotSalesListViewController.h"

@implementation CTGoodService

CL_EXPORT_MODULE(CTGoodListServiceProtocol)

- (UIViewController *)goodListViewControllerWithCategoryId:(NSString *)categoryId{
    CTGoodListViewController *vc = [CTGoodListViewController new];
    vc.category_id = categoryId;
    return vc;
}

- (UIViewController *)goodDetailViewControllerWithGoodId:(NSString *)goodId{
    CTGoodDetailViewController * vc = [CTGoodDetailViewController new];
    vc.goog_id = goodId;
    return vc;
}

- (UIViewController *)hotsalesViewController{
    return [CThotSalesListViewController new];
}

- (UIViewController *)nineListViewController{
    return [CTNineNineListViewController new];
}

@end
