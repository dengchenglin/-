//
//  CTOrderListViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseListViewController.h"

#import "CTOrderPageController.h"

@interface FJOrderListViewControllerfj : CTBaseListViewController
@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@property (nonatomic, assign) CTOrderStatus status;

@end
