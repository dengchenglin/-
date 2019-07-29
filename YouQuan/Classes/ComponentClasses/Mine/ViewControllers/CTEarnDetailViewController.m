//
//  CTEarnDetailViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTEarnDetailViewController.h"

#import "CTEarnTrendViewController.h"

#import "CTEarnDescView.h"

#import "CTSevenTrendView.h"

#import "CTEarnTimeView.h"

#import "CLContainerView.h"

#import "CTNetworkEngine+Member.h"

#import "CTProfitShareViewController.h"

@interface CTEarnDetailViewController ()

@property (nonatomic, strong) CLContainerView *containerView;

@property (nonatomic, strong) CTEarnDescView *descView;

@property (nonatomic, strong) CTSevenTrendView *trendView;

@property (nonatomic, strong) CTEarnTimeView *yesterdayView;

@property (nonatomic, strong) CTEarnTimeView *todayView;

@property (nonatomic, strong) CTEarnTimeView *thisMonthView;

@property (nonatomic, strong) CTEarnTimeView *lastMonthView;

@property (nonatomic, strong) CTMyEarnModel *model;

@end

@implementation CTEarnDetailViewController

- (CLContainerView *)containerView{
    if(!_containerView){
        _containerView = [[CLContainerView alloc]init];
        _containerView.backgroundColor = CTBackGroundGrayColor;
    }
    return _containerView;
}

- (CTEarnDescView *)descView{
    if(!_descView){
        _descView = NSMainBundleClass(CTEarnDescView.class);
    }
    return _descView;
}

- (CTSevenTrendView *)trendView{
    if(!_trendView){
        _trendView = NSMainBundleClass(CTSevenTrendView.class);
    }
    return _trendView;
}

- (CTEarnTimeView *)todayView{
    if(!_todayView){
        _todayView = NSMainBundleClass(CTEarnTimeView.class);
        _todayView.timeTitleLabel.text = @"今日返利";
    }
    return _todayView;
}
- (CTEarnTimeView *)yesterdayView{
    if(!_yesterdayView){
        _yesterdayView = NSMainBundleClass(CTEarnTimeView.class);
        _yesterdayView.timeTitleLabel.text = @"昨日返利";
    }
    return _yesterdayView;
}
- (CTEarnTimeView *)thisMonthView{
    if(!_thisMonthView){
        _thisMonthView = NSMainBundleClass(CTEarnTimeView.class);
        _thisMonthView.timeTitleLabel.text = @"本月返利";
    }
    return _thisMonthView;
}
- (CTEarnTimeView *)lastMonthView{
    if(!_lastMonthView){
        _lastMonthView = NSMainBundleClass(CTEarnTimeView.class);
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
    [CTRequest incomeDetailWithCallback:^(id data, CLRequest *request, CTNetError error) {
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
        CTEarnTrendViewController *vc = [[CTEarnTrendViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.descView.withdrawButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [[CTModuleManager withdrawService] pushCashFromViewController:self];
        
    }];

}
- (void)share{
    CTProfitShareViewController *vc = [[CTProfitShareViewController alloc]init];
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
//    if([self.model.all_money integerValue] || [self.model.valuation_money integerValue]){
//        CTProfitShareViewController *vc = [[CTProfitShareViewController alloc]init];
//        vc.model = _model;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else{
//        [[CTModuleManager shareService] pushShareFromViewController:self];
//    }
 
}

@end
