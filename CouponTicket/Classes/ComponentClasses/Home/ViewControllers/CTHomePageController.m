//
//  CTHomePageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomePageController.h"

#import "CTHomeTopView.h"

#import "UIPageControlManager.h"

#import "CTHomeViewModel.h"

#import "CTHomeViewController.h"

#import "CTHomeCatoryViewController.h"

@interface CTHomePageController ()<UIPageControlManagerDataSoure,UIPageControlManagerDelegate,LMSegmentedControlDelegate>

@property (nonatomic, strong) CTHomeTopView *topView;


@property (nonatomic, strong) NSMutableArray <UIViewController *>*viewControllers;

@property (nonatomic, strong) UIPageControlManager *pageControlManager;

@property (nonatomic, strong) CTHomeViewModel *viewModel;

@end

@implementation CTHomePageController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray <UIViewController *>*)viewControllers{
    if(!_viewControllers){
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}

- (CTHomeTopView *)topView{
    if(!_topView){
        _topView = [[CTHomeTopView alloc]init];
        _topView.categoryControl.segmentedControl.delegate = self;
    }
    return _topView;
}

- (CTHomeViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTHomeViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.hideSystemNavBarWhenAppear = YES;
    self.pageControlManager = [[UIPageControlManager alloc]initWithViewController:self];
    self.pageControlManager.delegate = self;
    self.pageControlManager.datasoure = self;
    
    [self.view addSubview:self.topView];
}


- (void)autoLayout{
    self.pageControlManager.pageViewControllerFrame = CGRectMake(0, NAVBAR_HEIGHT + 40, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT - 40);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT + 40);
    }];
}

- (void)request{
    [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
         [self reloadData:nil];
    } repeats:NO];
   
}

- (void)reloadData:(id)data{
    self.viewModel.category_titles = @[@"今日精选",@"女装",@"母婴儿童",@"内衣",@"居家",@"男装",@"女装"];
    for(int i = 0;i < self.viewModel.category_titles.count;i ++){
        UIViewController *vc;
        if(i == 0){
            vc = [[CTHomeViewController alloc]init];
        }
        else{
            vc = [[CTHomeCatoryViewController alloc]init];
        }
        [self.viewControllers addObject:vc];
    }
    
    self.topView.categoryControl.titles = _viewModel.category_titles;
    [self.pageControlManager reloadData];
}


#pragma mark - UIPageControlManagerDataSoure
- (NSArray<UIViewController *> *)viewControllersWithPageControlManager:(UIPageControlManager *)pageControlManager{
    return self.viewControllers;
}

- (void)didTransitionToIndex:(NSInteger)index pageControlManager:(UIPageControlManager *)pageControlManager{
    [self.topView.categoryControl.segmentedControl scrollToIndex:index];
}


#pragma mark - LMSegmentedControlDelegate

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self.pageControlManager scrollPageToIndex:index];
}




@end
