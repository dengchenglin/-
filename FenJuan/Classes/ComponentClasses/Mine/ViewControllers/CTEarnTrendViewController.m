//
//  CTEarnTrendViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTEarnTrendViewController.h"

#import "CTThirtyProfitView.h"

#import "CTThirtyTrendView.h"

#import "CTThirtyProfitHeadView.h"

#import "CTEarnTrendCell.h"

#import "CTNetworkEngine+Member.h"

#import "CTEarnTrendModel.h"

@interface CTEarnTrendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CTThirtyProfitView *profitView;

@property (nonatomic, strong) CTThirtyTrendView *trendView;

@property (nonatomic, strong) CTThirtyProfitHeadView *profitHeadView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) CTEarnTrendModel *model;

@end

@implementation CTEarnTrendViewController

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
        [_headView addSubview:self.profitView];
        [_headView addSubview:self.trendView];
        [_headView addSubview:self.profitHeadView];
        [self.profitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [self.trendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.profitView.mas_bottom);
            make.left.right.mas_equalTo(0);
        }];
        [self.profitHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.trendView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _headView;
}

- (void)setUpUI{
    self.title = @"返利走势";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.tableView];
}


- (void)autoLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest incomeTrendWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            self.model = [CTEarnTrendModel yy_modelWithDictionary:data];
            if(!self.model.day30_lists.count){
                [MBProgressHUD showMBProgressHudWithTitle:@"您暂无返利记录" hideAfterDelay:1.0 complited:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                return ;
            }
            self.profitView.model = _model;
            self.trendView.url = _model.trend_chart_url;
            [self.tableView reloadData];
        }
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.trendView setHeightDidChangeBlock:^(CGFloat height) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = [self.headView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, 1000)].height;
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
