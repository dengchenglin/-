
//
//  CTMyTeamPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMyTeamPageController.h"

#import "LMSegmentedControl.h"

#import "CTTeamListViewController.h"

@interface CTMyTeamPageController ()<LMSegmentedControlDelegate>
@property (nonatomic, strong) LMSegmentedControl *segmentedControl;
@end

@implementation CTMyTeamPageController

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]init];
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.delegate = self;
        _segmentedControl.segmentedControlType = LMSegmentedControlScreen;
        _segmentedControl.selectedLineWidth = 26;
        _segmentedControl.selectedLineHeight = 4;
        _segmentedControl.selectedLineColor = HexColor(@"#FFC726");
        _segmentedControl.titleNormalColor = RGBColor(80, 80, 80);
        _segmentedControl.titleSelectedColor = RGBColor(20, 20, 20);

    }
    return _segmentedControl;
}

- (void)setUpUI{
    self.title = @"我的团队";
    self.hideNavBarBottomLine = YES;
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.segmentedControl];
    self.contentInsets = UIEdgeInsetsMake(45, 0, 0, 0);
}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)reloadView{
    NSArray *titles = @[@"全部(268人)",@"直属用户(168人)",@"间接用户(100人)"];
    dispatch_async(dispatch_get_main_queue(), ^{
        _segmentedControl.titles = titles;
    });
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < titles.count;i ++){
        CTTeamListViewController *vc = [[CTTeamListViewController alloc]init];
        vc.teamKind = i;
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
