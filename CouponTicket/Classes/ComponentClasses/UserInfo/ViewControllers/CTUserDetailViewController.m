//
//  CTUserDetailViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTUserDetailViewController.h"

#import "CTUserInfoView.h"

#import "CTThirtyProfitView.h"

#import "CTThirtyProfitHeadView.h"

#import "CTThirtyTrendView.h"

#import "CTEarnTrendCell.h"

#import "CTNetworkEngine+Member.h"

#import "CTUserInfoModel.h"

@interface CTUserDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CTUserInfoView *infoView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CTThirtyProfitView *profitView;

@property (nonatomic, strong) CTThirtyTrendView *trendView;

@property (nonatomic, strong) CTThirtyProfitHeadView *profitHeadView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) CTUserInfoModel *model;

@end

@implementation CTUserDetailViewController

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 245, 245);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNibWithClass:CTEarnTrendCell.class];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CTUserInfoView *)infoView{
    if(!_infoView){
        _infoView = NSMainBundleClass(CTUserInfoView.class);
    }
    return _infoView;
}

- (CTThirtyProfitView *)profitView{
    if(!_profitView){
        _profitView = NSMainBundleClass(CTThirtyProfitView.class);
    }
    return _profitView;
}

- (CTThirtyTrendView *)trendView{
    if(!_trendView){
        _trendView = NSMainBundleClass(CTThirtyTrendView.class);
    }
    return _trendView;
}

- (CTThirtyProfitHeadView *)profitHeadView{
    if(!_profitHeadView){
        _profitHeadView = NSMainBundleClass(CTThirtyProfitHeadView.class);
    }
    return _profitHeadView;
}

- (UIView *)headView{
    if(!_headView){
        _headView = [UIView new];
        _headView.backgroundColor = CTBackGroundGrayColor;
        [_headView addSubview:self.infoView];
        [_headView addSubview:self.profitHeadView];
        [_headView addSubview:self.profitView];
        [_headView addSubview:self.trendView];
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
        }];
        [self.profitHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.infoView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        [self.profitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.profitHeadView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [self.trendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.profitView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
        }];
     
    }
    return _headView;
}

- (void)setUpUI{
    self.title = @"用户名";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.tableView];
}

- (void)autoLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.trendView setHeightDidChangeBlock:^(CGFloat height) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

- (void)request{
    [CTRequest teamUserDetailWithUid:_userId callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            self.model = [CTUserInfoModel yy_modelWithDictionary:data];
            self.infoView.user = self.model.user;
            self.profitView.userInfo = self.model;
            self.trendView.url = self.model.trend_chart_url;
            [self.tableView reloadData];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = [self.headView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.day30_lists.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTEarnTrendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTEarnTrendCell.class)];
    cell.model = self.model.day30_lists[indexPath.row];
    return cell;
}
@end
