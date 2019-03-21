//
//  CTOrderPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTOrderPageController.h"

#import "CTOrderListViewController.h"

#import "LMSegmentedControl.h"

@interface CTOrderPageController ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@end

@implementation CTOrderPageController

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]init];
        _segmentedControl.titleNormalColor = RGBColor(153, 153, 153);
        _segmentedControl.titleSelectedColor = RGBColor(255, 97, 36);
        _segmentedControl.delegate = self;
    }
    return _segmentedControl;
}

- (void)setUpUI{
    self.title = @"推广订单";
    self.hideNavBarBottomLine = YES;
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.segmentedControl];
    self.contentInsets = UIEdgeInsetsMake(40, 0, 0, 0);
}
- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}

- (void)reloadView{
    NSArray *titles = @[@"全部",@"已付款",@"已结算",@"已失效",@"退款/售后"];
    NSArray *status = @[@"",@"12",@"3",@"13",@"14"];
    dispatch_async(dispatch_get_main_queue(), ^{
        _segmentedControl.titles = titles;
    });
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < titles.count;i ++){
        CTOrderListViewController *vc = [[CTOrderListViewController alloc]init];
        vc.status = [status[i] integerValue];
        [array addObject:vc];
    }
    self.viewControllers = array;
}


- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self scrollToIndex:index];
}
- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
}
@end
