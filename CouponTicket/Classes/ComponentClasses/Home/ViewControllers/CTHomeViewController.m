//
//  CTHomeViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeViewController.h"

#import "CTHomeViewModel.h"

#import "CTHomeBannerView.h"

#import "CTHomeAdvertView.h"

#import "CTHomeNavView.h"

#import "CTHomeSalesView.h"

#import "CTHomeNewestHeadView.h"

#import "CTGoodListCell.h"

@interface CTHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) CTHomeBannerView *bannerView;

@property (nonatomic, strong) CTHomeAdvertView *advertView;

@property (nonatomic, strong) CTHomeNavView *navView;

@property (nonatomic, strong) CTHomeSalesView *salesView;

@property (nonatomic, strong) CTHomeNewestHeadView *newestHeadView;

@property (nonatomic, strong) CTHomeViewModel *viewModel;

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
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CTHomeBannerView *)bannerView{
    if(!_bannerView){
        _bannerView = [[CTHomeBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
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
    }];
    [self.salesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        //make.height.mas_equalTo(260);
    }];
    [self.newestHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.salesView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
    }];
    
}

- (void)request{
    self.viewModel.banner_imgs = [self banner_imgs];
    self.bannerView.banner_imgs = _viewModel.banner_imgs;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    return cell;
}

- (NSArray *)banner_imgs{
    return @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1547901093459&di=e3274b8819e9a976a7fc692844282dca&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01b266571dd33b32f875a3996d817b.jpg%402o.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1547901093118&di=cfe5a572f0a28601dccdaa857c6be7d2&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F019a0558be22d6a801219c77d0578a.jpg%402o.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1547901093460&di=2fc7833f73723faae1d70656c473e8c1&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0111ee55440a300000019ae9c33662.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1547901093460&di=3bd463e5cccc5e67de8606206da7538d&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01a39258eddb07a8012049ef53b617.jpg%401280w_1l_2o_100sh.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1547901093460&di=3435b65b6d3eda3610999f68501a5f27&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01481559841b3da801215603a36220.jpg%402o.jpg"];
}

@end
