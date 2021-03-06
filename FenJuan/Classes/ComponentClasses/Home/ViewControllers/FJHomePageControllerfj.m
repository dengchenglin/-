//
//  CTHomePageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHomePageControllerfj.h"

#import "FJHomeTopViewfj.h"

#import "UIPageControlManager.h"

#import "FJHomeViewModelfj.h"

#import "FJHomeViewControllerfj.h"

#import "FJHomeCatoryViewControllerfj.h"

#import "CTMainCategoryView.h"

#import "CTNetworkEngine+Index.h"

#import "CTNetworkEngine+H5Url.h"

@interface FJHomePageControllerfj ()<UIPageControlManagerDataSoure,UIPageControlManagerDelegate>

@property (nonatomic, strong) FJHomeTopViewfj *topView;


@property (nonatomic, strong) NSMutableArray <UIViewController *>*viewControllers;

@property (nonatomic, strong) UIPageControlManager *pageControlManager;

@property (nonatomic, strong) FJHomeViewModelfj *viewModel;

@end

@implementation FJHomePageControllerfj

- (NSMutableArray <UIViewController *>*)viewControllers{
    if(!_viewControllers){
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}

- (FJHomeTopViewfj *)topView{
    if(!_topView){
        _topView = [[FJHomeTopViewfj alloc]init];

    }
    return _topView;
}
- (void)setUpUI{
    self.hideSystemNavBarWhenAppear = YES;
    self.pageControlManager = [[UIPageControlManager alloc]initWithViewController:self];
    self.pageControlManager.delegate = self;
    self.pageControlManager.datasoure = self;
    [self.view addSubview:self.topView];
}


- (void)autoLayout{
    self.pageControlManager.pageViewControllerFrame = CGRectMake(0, NAVBAR_HEIGHT + 80, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT - 80);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT + 80);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    
    //消息
    [self.topView.searchBar.messageButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [[CTModuleManager messageService]pushMessageFromViewController:self];
    }];
    //二维码邀请页面
    [self.topView.navBar.scanButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [[CTModuleManager shareService]fj_pushShareFromViewController:self];
    }];
    //搜索
    [self.topView.searchBar setClickSearchBarBlock:^{
        @strongify(self)
        UIViewController *searchVc = [[CTModuleManager searchService]rootViewController];
        [self.navigationController pushViewController:searchVc animated:YES];
    }];
    //点击了分类
    [self.topView setClickCategoryBlock:^(NSInteger index) {
        @strongify(self)
        [self.pageControlManager scrollPageToIndex:index];
    }];
    //省钱攻略
    [self.topView.navBar.sqglView addActionWithBlock:^(id target) {
        @strongify(self)
   
        UIViewController *webVc = [[CTModuleManager webService]fj_pushWebFromViewController:self url:CTH5UrlForType(CTH5UrlSaveMoneyStrategy)];
        webVc.title = @"省钱攻略";
    }];
    //领券
    [self.topView.navBar.lqView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *webVc = [[CTModuleManager webService] fj_pushWebFromViewController:self url:CTH5UrlForType(CTH5UrlGetTikcetAuide)];
        webVc.title = @"领券指南";
    }];
}


- (void)request{
    [CTRequest indexWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [LMDataResultView hideDataResultOnView:self.view];
        if(!error){
            [self reloadData:data];
        }
        else if (!self.viewModel){
            [LMDataResultView showNoNetErrorResultOnView:self.view clickRefreshBlock:^{
                [self request];
            }];
        }
    } isCaches:YES];

}

- (void)reloadData:(id)data{

   FJHomeModelfj *model = [FJHomeModelfj yy_modelWithDictionary:data];
    self.viewModel = [FJHomeViewModelfj bindModel:model];
    [self.viewControllers removeAllObjects];
    for(int i = 0;i < self.viewModel.model.cate.count;i ++){
        UIViewController *vc;
        if(i == 0){
            vc = [[FJHomeViewControllerfj alloc]init];
            ((FJHomeViewControllerfj *)vc).viewModel = _viewModel;
        }
        else{
            vc = [[FJHomeCatoryViewControllerfj alloc]init];
            ((FJHomeCatoryViewControllerfj *)vc).cateId = self.viewModel.model.cate[i].uid;
        }
        ((id<CTPageControllerProtocol>)vc).bounds = CGRectMake(0, 0, self.pageControlManager.pageViewControllerFrame.size.width, self.pageControlManager.pageViewControllerFrame.size.height);
        [self.viewControllers addObject:vc];
    }
    
    self.topView.categoryModels = _viewModel.model.cate;
    [self.pageControlManager reloadData];
}


#pragma mark - UIPageControlManagerDataSoure
- (NSArray<UIViewController *> *)viewControllersWithPageControlManager:(UIPageControlManager *)pageControlManager{
    return self.viewControllers;
}

- (void)didTransitionToIndex:(NSInteger)index pageControlManager:(UIPageControlManager *)pageControlManager{
    [self.topView.categoryControl.segmentedControl scrollToIndex:index];
}



- (NSArray *)testCategory{

    return @[@{@"title":@"今日精选"},@{@"title":@"女装"},@{@"title":@"母婴儿童"},@{@"title":@"内衣"},@{@"title":@"居家"},@{@"title":@"男装"},@{@"title":@"女装"},@{@"title":@"内裤"},@{@"title":@"电器"},@{@"title":@"酒水"},@{@"title":@"玩具"}];
}
@end
