//
//  CTMineViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMineViewController.h"

#import "CTNavBar.h"

#import "CLContainerView.h"

#import "CTMineHeadView.h"

#import "CTMineEarnView.h"

#import "CTMineOrderView.h"

#import "CTMineToolView.h"

#import "CTMineNavItemView.h"

#import "CTMyCollectListViewController.h"

#import "CTEarnRankPageController.h"

#import "CTEarnDetailViewController.h"

#import "CTOrderPageController.h"

#import "CTMyTeamPageController.h"

#import "CTNetworkEngine+Member.h"

#import "CTNetworkEngine+H5Url.h"

#import "CTMyEarnModel.h"

@interface CTMineViewController ()

@property (nonatomic, strong) CTNavBar *navBar;

@property (nonatomic, strong) CTMineNavItemView *navItemView;

@property (nonatomic, strong) CLContainerView *containerView;

@property (nonatomic, strong) CTMineHeadView *headView;

@property (nonatomic, strong) CTMineEarnView *earnView;

@property (nonatomic, strong) CTMineOrderView *orderView;

@property (nonatomic, strong) CTMineToolView *toolView;

@end

@implementation CTMineViewController

- (CTNavBar *)navBar{
    if(!_navBar){
        _navBar = NSMainBundleClass(CTNavBar.class);
        _navBar.alpha = 0;
        _navBar.title = @"我的";
    }
    return _navBar;
}

- (CTMineNavItemView *)navItemView{
    if(!_navItemView){
        _navItemView = NSMainBundleClass(CTMineNavItemView.class);
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

- (CTMineHeadView *)headView{
    if(!_headView){
        _headView = NSMainBundleClass(CTMineHeadView.class);
    }
    return _headView;
}

- (CTMineEarnView *)earnView{
    if(!_earnView){
        _earnView = NSMainBundleClass(CTMineEarnView.class);
    }
    return _earnView;
}

- (CTMineOrderView *)orderView{
    if(!_orderView){
        _orderView = NSMainBundleClass(CTMineOrderView.class);
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
        CGFloat top = (188 + NAVBAR_TOP)/2 - 35;
        make.top.mas_equalTo(top);
        make.size.mas_equalTo(CGSizeMake(72, 30));
        make.right.mas_equalTo(-15);
    }];
}
- (void)request{
    [CTRequest userInfoWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.containerView.tableView endRefreshing];
        if(!error){
            [CTAppManager saveUserWithInfo:data[@"user"]];
            self.headView.user = [CTAppManager user];
            self.earnView.user = [CTAppManager user];
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
            make.bottom.mas_equalTo(-20);
        }];
        config.sectioView = sectionView1;
        config.sectionHeight = 338 + NAVBAR_TOP;
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
        config.sectionHeight = 345;
        config.space = 10;
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.containerView.tableView addHeaderRefreshWithCallBack:^{
        @strongify(self);
        [self request];
    }];
    //我的信息
    [self.headView.iconImageView addActionWithBlock:^(id  _Nonnull target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager userInfoService] viewControllerForUserId:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //收益排行
    [self.earnView.earnButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        CTEarnRankPageController *vc = [[CTEarnRankPageController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //收益明细
    [self.earnView.earndetailButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        CTEarnDetailViewController *vc = [[CTEarnDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
    //邀请券友
    [self.toolView.inviteView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *shareVc = [[CTModuleManager shareService] rootViewController];
        [self.navigationController pushViewController:shareVc animated:YES];
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
        CTMyTeamPageController *vc = [CTMyTeamPageController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //我的收藏
    [self.toolView.collectView addActionWithBlock:^(id target) {
        @strongify(self)
        CTMyCollectListViewController *vc = [CTMyCollectListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //领券指南
    [self.toolView.guideView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *webVc = [[CTModuleManager webService] pushWebFromViewController:self url:CTH5UrlForType(CTH5UrlGetTikcetAuide)];
        webVc.title = @"领券指南";
    }];
    //我的邀请码
    [self.toolView.inviteCodeView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *shareVc = [[CTModuleManager shareService] rootViewController];
        [self.navigationController pushViewController:shareVc animated:YES];
    }];
    //常见问题
    [self.toolView.questionView addActionWithBlock:^(id target) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager toolService]questionViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    //立即提现
    void(^withdrawBlock)(void) = ^{
        @strongify(self)
        UIViewController *vc = [[CTModuleManager withdrawService] rootViewController];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.earnView.withdrawButton touchUpInsideSubscribeNext:^(id x) {
        if([CTAppManager user].pay_account){
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
    //导航渐变效果
    [self.containerView setScrollBlock:^(CGPoint contentOffest) {
        @strongify(self)
        CGFloat top = (188 + NAVBAR_TOP)/2 - 35;
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
