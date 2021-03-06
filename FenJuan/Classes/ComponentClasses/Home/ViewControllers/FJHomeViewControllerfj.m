//
//  CTHomeViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHomeViewControllerfj.h"

#import "FJHomeBannerViewfj.h"

#import "FJHomeAdvertViewfj.h"

#import "FJHomeNavViewfj.h"

#import "FJHomeSalesViewfj.h"

#import "FJHomeNewestHeadViewfj.h"

#import "CTGoodListCell.h"

#import "FJHomeSpreeShopViewfj.h"

#import "CTNetworkEngine+Index.h"

@interface FJHomeViewControllerfj ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) FJHomeBannerViewfj *bannerView;

@property (nonatomic, strong) FJHomeAdvertViewfj *advertView;

@property (nonatomic, strong) FJHomeNavViewfj *navView;

@property (nonatomic, strong) FJHomeSpreeShopViewfj *spreeShopView;

@property (nonatomic, strong) FJHomeSalesViewfj *salesView;

@property (nonatomic, strong) FJHomeNewestHeadViewfj *newestHeadView;

@end

@implementation FJHomeViewControllerfj

@synthesize bounds = _bounds;

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 245, 245);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNibWithClass:CTGoodListCell.class];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        } 
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (FJHomeBannerViewfj *)bannerView{
    if(!_bannerView){
        _bannerView = [[FJHomeBannerViewfj alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.48 * SCREEN_WIDTH)];
    }
    return _bannerView;
}

- (FJHomeAdvertViewfj *)advertView{
    if(!_advertView){
        _advertView = [[FJHomeAdvertViewfj alloc]init];
    }
    return _advertView;
}

- (FJHomeNavViewfj *)navView{
    if(!_navView){
        _navView = NSMainBundleClass(FJHomeNavViewfj.class);
    }
    return _navView;
}

- (FJHomeSpreeShopViewfj *)spreeShopView{
    if(!_spreeShopView){
        _spreeShopView = NSMainBundleClass(FJHomeSpreeShopViewfj.class);
    }
    return _spreeShopView;
}

- (FJHomeSalesViewfj *)salesView{
    if(!_salesView){
        _salesView = NSMainBundleClass(FJHomeSalesViewfj.class);
    }
    return _salesView;
}

- (FJHomeNewestHeadViewfj *)newestHeadView{
    if(!_newestHeadView){
        _newestHeadView = NSMainBundleClass(FJHomeNewestHeadViewfj.class);
    }
    return _newestHeadView;
}

- (UIView *)headView{
    if(!_headView){
        _headView = [UIView new];
        [_headView addSubview:self.bannerView];
        [_headView addSubview:self.advertView];
        [_headView addSubview:self.navView];
        [_headView addSubview:self.spreeShopView];
        [_headView addSubview:self.salesView];
        [_headView addSubview:self.newestHeadView];
    }
    return _headView;
}


- (FJHomeViewModelfj *)viewModel{
    if(!_viewModel){
        _viewModel = [FJHomeViewModelfj new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.hideSystemNavBarWhenAppear = YES;
    [self.view addSubview:self.tableView];
}

- (void)autoLayout{
    [self.headView class];
    [self.advertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.height);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH/3.75);
    }];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.advertView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH*242/375);
    }];
    [self.spreeShopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(510);
    }];
    [self.salesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.spreeShopView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(260);
    }];
    [self.newestHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.salesView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)reloadView{
    //首页数据在上一层传过来的
    if(_viewModel){
        self.bannerView.banner_imgs = [self.viewModel.model.advs map:^id(NSInteger index, CTActivityModel *element) {
            return element.img?:@"";
        }];
        self.advertView.model = self.viewModel.model.activity_banner;
        self.navView.activitys = self.viewModel.model.activity;
        self.spreeShopView.model = self.viewModel.model.cur_time_buy;
        self.salesView.model = self.viewModel.model.hot_goods;
        [self.advertView mas_updateConstraints:^(MASConstraintMaker *make) {
            if(self.advertView.model){
                 make.height.mas_equalTo(SCREEN_WIDTH/3.75);
            }
            else{
                 make.height.mas_equalTo(0);
            }
        }];
        [self.spreeShopView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.navView.mas_bottom).offset(self.viewModel.spreeHeight?10:0);
            make.height.mas_equalTo(self.viewModel.spreeHeight);
        }];
        [self.salesView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.spreeShopView.mas_bottom).offset(self.viewModel.saleHeight?10:0);
            make.height.mas_equalTo(self.viewModel.saleHeight);
        }];
        [self.tableView reloadData];
    }
}

- (void)loadData{
    [CTRequest indexWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.tableView endRefreshing];
        if(!error){
            [self reloadData:data];
        }
    } isCaches:NO];
}

- (void)reloadData:(id)data{
    FJHomeModelfj *model = [FJHomeModelfj yy_modelWithDictionary:data];
    self.viewModel = [FJHomeViewModelfj bindModel:model];
    [self reloadView];
}

- (void)setUpEvent{
    @weakify(self)
    //刷新
    [self.tableView addHeaderRefreshWithCallBack:^{
        @strongify(self)
        [self loadData];
    }];
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:CTRefreshHomeNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self loadData];
    }];
    //轮播
    [self.bannerView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        [CTModuleHelper showCtVcFromViewController:self model:self.viewModel.model.advs[index]];
    }];
    //活动数据
    [self.advertView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService] fj_goodListViewControllerWithActivityId:self.viewModel.model.activity_banner.uid];
        vc.title = self.viewModel.model.activity_banner.title;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //五个导航按钮
    [self.navView setClickItemBlock:^(CTActivityModel *model) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService] fj_goodListViewControllerWithActivityId:model.uid];
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //整点抢购
    [self.spreeShopView.headView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService] spreeShopViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //整点抢购商品点击
    [self.spreeShopView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        if(![self.viewModel.model.cur_time_buy.goods safe_objectAtIndex:index])return ;
        UIViewController *vc = [[CTModuleManager goodListService]fj_goodDetailViewControllerWithGoodId:self.viewModel.model.cur_time_buy.goods[index].uid];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //销量榜
    [self.salesView.titleheadView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService]hotsalesViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //销量榜商品点击
    [self.salesView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
         if(![self.viewModel.model.hot_goods.goods safe_objectAtIndex:index])return ;
        UIViewController *vc = [[CTModuleManager goodListService]fj_goodDetailViewControllerWithGoodId:self.viewModel.model.hot_goods.goods[index].uid];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = [self.headView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.model.now_goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    cell.viewModel = self.viewModel.now_goods[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService]fj_goodDetailViewControllerWithGoodId:self.viewModel.model.now_goods[indexPath.row].uid];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
