//
//  CTMineViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJMineViewControllerfj.h"

#import "CTNavBar.h"

#import "CLContainerView.h"

#import "FJMineHeadViewfj.h"

#import "FJMineEarnViewfj.h"

#import "FJMineOrderViewfj.h"

#import "CTMineToolView.h"

#import "FJMineNavItemViewfj.h"

#import "FJMyCollectListViewControllerfj.h"

#import "FJEarnRankPageControllerfj.h"

#import "FJEarnDetailViewController.h"

#import "CTOrderPageController.h"

#import "FJMyTeamPageControllerfj.h"

#import "CTNetworkEngine+Member.h"

#import "CTNetworkEngine+H5Url.h"

#import "CTMyEarnModel.h"

#import "FJMineBalanceViewfj.h"

@interface FJMineViewControllerfj ()

@property (nonatomic, strong) CTNavBar *navBar;

@property (nonatomic, strong) FJMineNavItemViewfj *navItemView;

@property (nonatomic, strong) CLContainerView *containerView;

@property (nonatomic, strong) FJMineHeadViewfj *headView;

@property (nonatomic, strong) FJMineEarnViewfj *earnView;

@property (nonatomic, strong) FJMineBalanceViewfj *balanceView;

@property (nonatomic, strong) FJMineOrderViewfj *orderView;

@property (nonatomic, strong) CTMineToolView *toolView;

@end

@implementation FJMineViewControllerfj

- (CTNavBar *)navBar{
    if(!_navBar){
        _navBar = NSMainBundleClass(CTNavBar.class);
        _navBar.alpha = 0;
        _navBar.title = @"我的";
    }
    return _navBar;
}

- (FJMineNavItemViewfj *)navItemView{
    if(!_navItemView){
        _navItemView = NSMainBundleClass(FJMineNavItemViewfj.class);
    }
    return _navItemView;
}

- (CLContainerView *)containerView{
    if(!_containerView){
        _containerView = [[CLContainerView alloc]init];
        _containerView.backgroundColor = CTBackGroundGrayColor;
    }
    return _containerView;
}

- (FJMineHeadViewfj *)headView{
    if(!_headView){
        _headView = NSMainBundleClass(FJMineHeadViewfj.class);
    }
    return _headView;
}

- (FJMineEarnViewfj *)earnView{
    if(!_earnView){
        _earnView = NSMainBundleClass(FJMineEarnViewfj.class);
    }
    return _earnView;
}

- (FJMineBalanceViewfj *)balanceView{
    if(!_balanceView){
        _balanceView = NSMainBundleClass(FJMineBalanceViewfj.class);
    }
    return _balanceView;
}

- (FJMineOrderViewfj *)orderView{
    if(!_orderView){
        _orderView = NSMainBundleClass(FJMineOrderViewfj.class);
    }
    return _orderView;
}

- (CTMineToolView *)toolView{
    if(!_toolView){
        _toolView = NSMainBundleClass(CTMineToolView.class);
    }
    return _toolView;
}

- (void)setUpUI{
    self.hideSystemNavBarWhenAppear = YES;
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.navItemView];
}

- (void)autoLayout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT - TABBAR_HEIGHT);
    }];
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT);
    }];
    [self.navItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat top = (160 + NAVBAR_TOP)/2 - 35;
        make.top.mas_equalTo(top);
        make.size.mas_equalTo(CGSizeMake(72, 30));
        make.right.mas_equalTo(-15);
    }];
}
- (void)request{
    [CTRequest fj_userInfoWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.containerView.tableView endRefreshing];
        if(!error){
            [CTAppManager saveUserWithInfo:data[@"user"]];
          
            self.headView.user = [CTAppManager user];
            self.earnView.user = [CTAppManager user];
            self.balanceView.user = [CTAppManager user];
            self.earnView.model = [CTMyEarnModel yy_modelWithDictionary:data];
            
        }
    }];
}
- (void)reloadView{
    [self.containerView removeAllObjects];
    @weakify(self)
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        UIView *sectionView1 = [UIView new];
        sectionView1.backgroundColor = CTBackGroundGrayColor;
        [sectionView1 addSubview:self.headView];
        [sectionView1 addSubview:self.earnView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(188 + NAVBAR_TOP);
        }];
        [self.earnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headView.mas_bottom).offset(-60);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
        config.sectioView = sectionView1;
        config.sectionHeight = 338 + NAVBAR_TOP;//290 + NAVBAR_TOP;
    }];
 
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        UIView *sectionView2 = [UIView new];
        sectionView2.backgroundColor = CTBackGroundGrayColor;
        [sectionView2 addSubview:self.balanceView];
        [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-20);
        }];
        config.sectioView = sectionView2;
        config.sectionHeight = 124;
    }];
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.orderView;
        config.sectionHeight = 160;
        config.space = 10;
    }];
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.toolView;
        config.sectionHeight = 220;
        config.space = 10;
        self.toolView.memberEquityView.hidden = ![CTAppManager sharedInstance].showMember;
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.containerView.tableView addHeaderRefreshWithCallBack:^{
        @strongify(self);
        [self request];
    }];
    //登录注册后刷新
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:CTDidLoginNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self request];
    }];
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:CTRefreshMineNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self request];
    }];

    //我的信息
    [self.headView.iconImageView addActionWithBlock:^(id  _Nonnull target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager userInfoService] viewControllerForUserId:[CTAppManager user].uid];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //收益排行
    [self.earnView.earnButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        FJEarnRankPageControllerfj *vc = [[FJEarnRankPageControllerfj alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //收益明细
    [self.balanceView.earndetailButton addActionWithBlock:^(id target) {
        @strongify(self)
        FJEarnDetailViewController *vc = [[FJEarnDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
    //提现
    [self.balanceView.withdrawButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [[CTModuleManager withdrawService] pushCashFromViewController:self];
        
    }];
    //推广订单
    [self.orderView.lookMoreView addActionWithBlock:^(id target) {
        @strongify(self)
        CTOrderPageController *vc = [[CTOrderPageController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.orderView.payedView addActionWithBlock:^(id target) {
        @strongify(self)
        CTOrderPageController *vc = [[CTOrderPageController alloc]init];
        vc.toIndex = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.orderView.calculatedView addActionWithBlock:^(id target) {
        @strongify(self)
        CTOrderPageController *vc = [[CTOrderPageController alloc]init];
        vc.toIndex = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.orderView.disabledView addActionWithBlock:^(id target) {
        @strongify(self)
        CTOrderPageController *vc = [[CTOrderPageController alloc]init];
        vc.toIndex = 3;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.orderView.refundView addActionWithBlock:^(id target) {
        @strongify(self)
        CTOrderPageController *vc = [[CTOrderPageController alloc]init];
        vc.toIndex = 4;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //设置
    [self.navItemView.setButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        UIViewController *setVc = [[CTModuleManager setService] rootViewController];
        [self.navigationController pushViewController:setVc animated:YES];
    }];
    //消息
    [self.navItemView.messageButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        UIViewController *messageVc = [[CTModuleManager messageService] rootViewController];
        [self.navigationController pushViewController:messageVc animated:YES];
    }];
    //我的团队
    [self.toolView.teamView addActionWithBlock:^(id target) {
        @strongify(self)
        FJMyTeamPageControllerfj *vc = [FJMyTeamPageControllerfj new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //我的收藏
    [self.toolView.collectView addActionWithBlock:^(id target) {
        @strongify(self)
        FJMyCollectListViewControllerfj *vc = [FJMyCollectListViewControllerfj new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //领券指南
    [self.toolView.guideView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *webVc = [[CTModuleManager webService] fj_pushWebFromViewController:self url:CTH5UrlForType(CTH5UrlGetTikcetAuide)];
        webVc.title = @"领券指南";
    }];
    //邀请券友
    [self.toolView.inviteCodeView addActionWithBlock:^(id target) {
        @strongify(self)
          [[CTModuleManager shareService] fj_pushMyInviteCodeFromViewController:self];
    }];
    //常见问题
    [self.toolView.questionView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager toolService]questionViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //会员权益
    [self.toolView.memberEquityView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager memberService]memberEquityViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //商学院
    [self.toolView.sxyView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager toolService]syxViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    //导航渐变效果
    [self.containerView setScrollBlock:^(CGPoint contentOffest) {
        @strongify(self)
        CGFloat top = (160 + NAVBAR_TOP)/2 - 35;
        CGFloat endTop = NAVBAR_HEIGHT - 37;
        CGFloat nowTop = top - contentOffest.y;
        if(nowTop <= endTop){
            nowTop = endTop;
        }
        [self.navItemView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nowTop);
        }];
        [self.view layoutIfNeeded];
        
        CGFloat startOffest = 50;
        CGFloat alpha = 0;
        if(contentOffest.y > startOffest){
            alpha = (contentOffest.y - startOffest)/80;
        }
        else{
            alpha = 0;
        }
        self.navBar.alpha = alpha;
    }];
}


@end
