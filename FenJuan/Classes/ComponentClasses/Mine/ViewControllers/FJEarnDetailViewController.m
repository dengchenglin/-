//
//  CTEarnDetailViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJEarnDetailViewController.h"

#import "FJEarnTrendViewControllerfj.h"

#import "FJEarnDescViewfj.h"

#import "CTSevenTrendView.h"

#import "FJEarnTimeViewfj.h"

#import "CLContainerView.h"

#import "CTNetworkEngine+Member.h"

#import "FJProfitShareViewControllerfj.h"

@interface FJEarnDetailViewController ()

@property (nonatomic, strong) CLContainerView *containerView;

@property (nonatomic, strong) FJEarnDescViewfj *descView;

@property (nonatomic, strong) CTSevenTrendView *trendView;

@property (nonatomic, strong) FJEarnTimeViewfj *yesterdayView;

@property (nonatomic, strong) FJEarnTimeViewfj *todayView;

@property (nonatomic, strong) FJEarnTimeViewfj *thisMonthView;

@property (nonatomic, strong) FJEarnTimeViewfj *lastMonthView;

@property (nonatomic, strong) CTMyEarnModel *model;

@end

@implementation FJEarnDetailViewController

- (CLContainerView *)containerView{
    if(!_containerView){
        _containerView = [[CLContainerView alloc]init];
        _containerView.backgroundColor = CTBackGroundGrayColor;
    }
    return _containerView;
}

- (FJEarnDescViewfj *)descView{
    if(!_descView){
        _descView = NSMainBundleClass(FJEarnDescViewfj.class);
    }
    return _descView;
}

- (CTSevenTrendView *)trendView{
    if(!_trendView){
        _trendView = NSMainBundleClass(CTSevenTrendView.class);
    }
    return _trendView;
}

- (FJEarnTimeViewfj *)todayView{
    if(!_todayView){
        _todayView = NSMainBundleClass(FJEarnTimeViewfj.class);
        _todayView.timeTitleLabel.text = @"今日返利";
    }
    return _todayView;
}
- (FJEarnTimeViewfj *)yesterdayView{
    if(!_yesterdayView){
        _yesterdayView = NSMainBundleClass(FJEarnTimeViewfj.class);
        _yesterdayView.timeTitleLabel.text = @"昨日返利";
    }
    return _yesterdayView;
}
- (FJEarnTimeViewfj *)thisMonthView{
    if(!_thisMonthView){
        _thisMonthView = NSMainBundleClass(FJEarnTimeViewfj.class);
        _thisMonthView.timeTitleLabel.text = @"本月返利";
    }
    return _thisMonthView;
}
- (FJEarnTimeViewfj *)lastMonthView{
    if(!_lastMonthView){
        _lastMonthView = NSMainBundleClass(FJEarnTimeViewfj.class);
        _lastMonthView.timeTitleLabel.text = @"上月返利";
    }
    return _lastMonthView;
}

- (void)setUpUI{
    self.title = @"返利明细";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self setRightButtonWithTitle:@"分享" font:[UIFont systemFontOfSize:14] titleColor:RGBColor(20, 20, 20) selector:@selector(share)];
    [self.view addSubview:self.containerView];

}

- (void)autoLayout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest fj_incomeDetailWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.containerView.tableView endRefreshing];
        if(!error){
            self.model = [CTMyEarnModel yy_modelWithDictionary:data];
            [self reloadView];
        }
    }];
}

- (void)reloadView{
    [self.containerView removeAllObjects];
    if(self.model){
        @weakify(self)
       
        [self.containerView addConfig:^(CLSectionConfig *config) {
            @strongify(self)
            config.sectioView = self.descView;
            config.sectionHeight = 258;
            config.space = 10;
        }];
        [self.containerView addConfig:^(CLSectionConfig *config) {
            @strongify(self)
            config.sectioView = self.trendView;
            config.sectionHeight = 1;//保证webView能加载内容
            config.space = 0;
            __weak CLSectionConfig *weakConfig = config;
            [self.trendView setHeightDidChangeBlock:^(CGFloat height) {
                @strongify(self)
                weakConfig.sectionHeight = height;
                weakConfig.space = height?10:0;
                [self.containerView reloadData];
            }];
        }];
        if(self.model.today){
            [self.containerView addConfig:^(CLSectionConfig *config) {
                @strongify(self)
                config.sectioView = self.todayView;
                config.sectionHeight = 127;
                config.space = 10;
            }];
        }
        if(self.model.yesterday){
            [self.containerView addConfig:^(CLSectionConfig *config) {
                @strongify(self)
                config.sectioView = self.yesterdayView;
                config.sectionHeight = 127;
                config.space = 10;
            }];
        }
        if(self.model.month){
            [self.containerView addConfig:^(CLSectionConfig *config) {
                @strongify(self)
                config.sectioView = self.thisMonthView;
                config.sectionHeight = 127;
                config.space = 10;
            }];
        }
        if(self.model.last_month){
            [self.containerView addConfig:^(CLSectionConfig *config) {
                @strongify(self)
                config.sectioView = self.lastMonthView;
                config.sectionHeight = 127;
                config.space = 10;
            }];
        }
        
        self.descView.model = self.model;
        self.trendView.url = self.model.trend_chart_url;
        self.todayView.info = self.model.today;
        self.yesterdayView.info = self.model.yesterday;
        self.thisMonthView.info = self.model.month;
        self.lastMonthView.info = self.model.last_month;
    }
}

- (void)setUpEvent{
    @weakify(self)
    [self.containerView.tableView addHeaderRefreshWithCallBack:^{
        @strongify(self)
        [self request];
    }];
    [self.trendView.headView addActionWithBlock:^(id target) {
        @strongify(self)
        FJEarnTrendViewControllerfj *vc = [[FJEarnTrendViewControllerfj alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.descView.withdrawButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [[CTModuleManager withdrawService] pushCashFromViewController:self];
        
    }];

}
- (void)share{
  
    if([self.model.all_money integerValue] || [self.model.valuation_money integerValue]){
        FJProfitShareViewControllerfj *vc = [[FJProfitShareViewControllerfj alloc]init];
        vc.model = _model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [[CTModuleManager shareService] fj_pushShareFromViewController:self];
    }
 
}

@end
