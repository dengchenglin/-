//
//  CTMemberEquityController.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/27.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "FJMemberEquityControllerfj.h"

#import "FJMemberEquityPageViewfj.h"

#import "FJEquitySegmentedControlfj.h"

#import "CTNetworkEngine+Member.h"

#import "FJMemberRebateModelfj.h"

@interface FJMemberEquityControllerfj ()<CTEquitySegmentedControlDelegate,CTMemberEquityPageViewDelegate>

@property (nonatomic, strong) FJEquitySegmentedControlfj *segmentedControl;

@property (nonatomic, strong) FJMemberEquityPageViewfj *pageView;

@end

@implementation FJMemberEquityControllerfj

- (FJEquitySegmentedControlfj *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [FJEquitySegmentedControlfj new];
        _segmentedControl.delegate = self;
    }
    return _segmentedControl;
}

- (FJMemberEquityPageViewfj *)pageView{
    if(!_pageView){
        _pageView = [FJMemberEquityPageViewfj new];
        _pageView.delegate = self;
    }
    return _pageView;
}

- (void)setUpUI{
    self.title = @"会员权益";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.pageView];
}


- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentedControl.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)request{
    [CTRequest fj_userPowerWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            self.pageView.list = data[@"list"];
            self.segmentedControl.titles = data[@"cate"];
        }
    }];
}



- (void)segmentedControl:(FJEquitySegmentedControlfj *)segmentedControl didScrollWithIndex:(NSInteger)index{
    [_pageView scrollToIndex:index];
}

- (void)pageView:(FJMemberEquityPageViewfj *)pageView didScrollWithIndex:(NSInteger)index{
    [_segmentedControl scrollToIndex:index];
}



@end
