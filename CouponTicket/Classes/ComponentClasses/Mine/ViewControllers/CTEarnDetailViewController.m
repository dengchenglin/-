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

#import "CTProfitShareViewController.h"

@interface CTEarnDetailViewController ()

@property (nonatomic, strong) CTEarnDescView *descView;

@property (nonatomic, strong) CTSevenTrendView *trendView;

@property (nonatomic, strong) CTEarnTimeView *yesterdayView;

@property (nonatomic, strong) CTEarnTimeView *todayView;

@property (nonatomic, strong) CTEarnTimeView *thisMonthView;

@property (nonatomic, strong) CTEarnTimeView *lastMonthView;

@end

@implementation CTEarnDetailViewController

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
        _todayView.timeTitleLabel.text = @"今日收益";
    }
    return _todayView;
}
- (CTEarnTimeView *)yesterdayView{
    if(!_yesterdayView){
        _yesterdayView = NSMainBundleClass(CTEarnTimeView.class);
        _yesterdayView.timeTitleLabel.text = @"昨日收益";
    }
    return _yesterdayView;
}
- (CTEarnTimeView *)thisMonthView{
    if(!_thisMonthView){
        _thisMonthView = NSMainBundleClass(CTEarnTimeView.class);
        _thisMonthView.timeTitleLabel.text = @"本月收益";
    }
    return _thisMonthView;
}
- (CTEarnTimeView *)lastMonthView{
    if(!_lastMonthView){
        _lastMonthView = NSMainBundleClass(CTEarnTimeView.class);
        _lastMonthView.timeTitleLabel.text = @"上月收益";
    }
    return _lastMonthView;
}

- (void)setUpUI{
    self.title = @"收益明细";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self setRightButtonWithTitle:@"分享" font:[UIFont systemFontOfSize:14] titleColor:RGBColor(20, 20, 20) selector:@selector(share)];
    self.scrollViewAvailable = YES;
    self.scrollView.backgroundColor = CTBackGroundGrayColor;
    [self.autoLayoutContainerView addSubview:self.descView];
    [self.autoLayoutContainerView addSubview:self.trendView];
    [self.autoLayoutContainerView addSubview:self.todayView];
    [self.autoLayoutContainerView addSubview:self.yesterdayView];
    [self.autoLayoutContainerView addSubview:self.thisMonthView];
    [self.autoLayoutContainerView addSubview:self.lastMonthView];
}

- (void)autoLayout{
    [self.descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(258);
    }];
    [self.trendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(235);
    }];
    [self.todayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.trendView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(127);
    }];
    [self.yesterdayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.todayView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(127);
    }];
    [self.thisMonthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yesterdayView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(127);
    }];
    [self.lastMonthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.thisMonthView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(127);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.trendView.headView addActionWithBlock:^(id target) {
        @strongify(self)
        CTEarnTrendViewController *vc = [[CTEarnTrendViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    void(^withdrawBlock)(void) = ^{
        @strongify(self)
        UIViewController *vc = [[CTModuleManager withdrawService] rootViewController];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.descView.withdrawButton touchUpInsideSubscribeNext:^(id x) {
        if([CTAppManager user].withInfo.account){
            withdrawBlock();
        }
        else{
            [[CTModuleManager loginService] pushBoundAlipayFromViewController:self completed:^{
                @strongify(self)
                [self.navigationController popToViewController:self animated:YES];
                
                withdrawBlock();
            }];
        }
        
    }];

}
- (void)share{
    CTProfitShareViewController *vc = [[CTProfitShareViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
