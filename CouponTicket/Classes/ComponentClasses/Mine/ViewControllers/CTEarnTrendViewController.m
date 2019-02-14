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

@interface CTEarnTrendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CTThirtyProfitView *profitView;

@property (nonatomic, strong) CTThirtyTrendView *trendView;

@property (nonatomic, strong) CTThirtyProfitHeadView *profitHeadView;

@property (nonatomic, strong) UIView *headView;

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
            make.height.mas_equalTo(240);
        }];
        [self.profitHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.trendView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
    }
    return _headView;
}

- (void)setUpUI{
    self.title = @"收益走势";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.tableView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 325;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTEarnTrendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTEarnTrendCell.class)];
    return cell;
}
@end
