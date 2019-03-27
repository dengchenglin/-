//
//  CTMemberEquityController.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/27.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTMemberEquityController.h"

#import "CTMemberEquityPageView.h"

#import "CTEquitySegmentedControl.h"

#import "CTNetworkEngine+Member.h"

#import "CTMemberRebateModel.h"

@interface CTMemberEquityController ()<CTEquitySegmentedControlDelegate,CTMemberEquityPageViewDelegate>

@property (nonatomic, strong) CTEquitySegmentedControl *segmentedControl;

@property (nonatomic, strong) CTMemberEquityPageView *pageView;

@end

@implementation CTMemberEquityController

- (CTEquitySegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [CTEquitySegmentedControl new];
        _segmentedControl.delegate = self;
    }
    return _segmentedControl;
}

- (CTMemberEquityPageView *)pageView{
    if(!_pageView){
        _pageView = [CTMemberEquityPageView new];
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
    [CTRequest userPowerWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            self.pageView.list = data[@"list"];
            self.segmentedControl.titles = data[@"cate"];
        }
    }];
}



- (void)segmentedControl:(CTEquitySegmentedControl *)segmentedControl didScrollWithIndex:(NSInteger)index{
    [_pageView scrollToIndex:index];
}

- (void)pageView:(CTMemberEquityPageView *)pageView didScrollWithIndex:(NSInteger)index{
    [_segmentedControl scrollToIndex:index];
}



@end
