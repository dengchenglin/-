//
//  CTHomeViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeViewController.h"

#import "CTHomeBannerView.h"

#import "CTHomeAdvertView.h"

#import "CTHomeNavView.h"

#import "CTHomeSalesView.h"

#import "CTHomeNewestHeadView.h"

#import "CTGoodListCell.h"

#import "CTHomeSpreeShopView.h"

#import "CTNetworkEngine+Index.h"


@interface CTHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) CTHomeBannerView *bannerView;

@property (nonatomic, strong) CTHomeAdvertView *advertView;

@property (nonatomic, strong) CTHomeNavView *navView;

@property (nonatomic, strong) CTHomeSpreeShopView *spreeShopView;

@property (nonatomic, strong) CTHomeSalesView *salesView;

@property (nonatomic, strong) CTHomeNewestHeadView *newestHeadView;

@end

@implementation CTHomeViewController

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

- (CTHomeBannerView *)bannerView{
    if(!_bannerView){
        _bannerView = [[CTHomeBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.48 * SCREEN_WIDTH)];
    }
    return _bannerView;
}

- (CTHomeAdvertView *)advertView{
    if(!_advertView){
        _advertView = [[CTHomeAdvertView alloc]init];
    }
    return _advertView;
}

- (CTHomeNavView *)navView{
    if(!_navView){
        _navView = NSMainBundleClass(CTHomeNavView.class);
    }
    return _navView;
}

- (CTHomeSpreeShopView *)spreeShopView{
    if(!_spreeShopView){
        _spreeShopView = NSMainBundleClass(CTHomeSpreeShopView.class);
    }
    return _spreeShopView;
}

- (CTHomeSalesView *)salesView{
    if(!_salesView){
        _salesView = NSMainBundleClass(CTHomeSalesView.class);
    }
    return _salesView;
}

- (CTHomeNewestHeadView *)newestHeadView{
    if(!_newestHeadView){
        _newestHeadView = NSMainBundleClass(CTHomeNewestHeadView.class);
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


- (CTHomeViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTHomeViewModel new];
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
    }
}

- (void)loadData{
    [CTRequest indexWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.tableView endRefreshing];
        if(!error){
            CTHomeModel *model = [CTHomeModel yy_modelWithDictionary:data];
            self.viewModel = [CTHomeViewModel bindModel:model];
            [self reloadView];
        }
    }];
}

- (void)setUpEvent{
    @weakify(self)
    //刷新
    [self.tableView addHeaderRefreshWithCallBack:^{
        @strongify(self)
        [self loadData];
    }];
    
    //五个导航按钮
    [self.navView setClickItemBlock:^(CTActivityModel *model) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService] goodListViewControllerWithActivityId:model.uid];
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //整点抢购
    [self.spreeShopView.headView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService] spreeShopViewController];
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
        UIViewController *vc = [[CTModuleManager goodListService]goodDetailViewControllerWithGoodId:self.viewModel.model.hot_goods.goods[index].uid];
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
    UIViewController *vc = [[CTModuleManager goodListService]goodDetailViewControllerWithGoodId:self.viewModel.model.now_goods[indexPath.row].uid];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
