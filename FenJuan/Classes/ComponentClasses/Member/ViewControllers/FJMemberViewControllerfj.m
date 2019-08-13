//
//  CTMemverViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJMemberViewControllerfj.h"

#import "CLContainerView.h"

#import "FJMemberHeadViewfj.h"

#import "FJMemberLevelViewfj.h"

#import "CTMemberEquityView.h"

#import "CTMemberPrivilegeView.h"

#import "FJMemberUpgradeViewfj.h"

#import "FJMemberChoicenessViewfj.h"

#import "FJMemberStrategyViewfj.h"

#import "CTNavBar.h"

#import "FJMemberEquityControllerfj.h"

#import "CTNetworkEngine+Member.h"

#import "CTMemberInfoModel.h"

#import "CTNetworkEngine+H5Url.h"

@interface FJMemberViewControllerfj ()

@property (nonatomic, strong) CTNavBar *navBar;

@property (nonatomic, strong) CLContainerView *containerView;

@property (nonatomic, strong) FJMemberHeadViewfj *headView;

@property (nonatomic, strong) FJMemberLevelViewfj *levelView;

@property (nonatomic, strong) CTMemberEquityView *equityView;

@property (nonatomic, strong) CTMemberPrivilegeView *privilegeView;

@property (nonatomic, strong) FJMemberUpgradeViewfj *upgradeView;

@property (nonatomic, strong) FJMemberChoicenessViewfj *choicenessView;

@property (nonatomic, strong) FJMemberStrategyViewfj *strategyView;

@property (nonatomic, strong) CTMemberInfoModel *model;

@end

@implementation FJMemberViewControllerfj

- (CTNavBar *)navBar{
    if(!_navBar){
        _navBar = NSMainBundleClass(CTNavBar.class);
        _navBar.backButton.hidden = YES;
        _navBar.alpha = 0;
        _navBar.title = @"会员中心";
    }
    return _navBar;
}

- (CLContainerView *)containerView{
    if(!_containerView){
        _containerView = [[CLContainerView alloc]init];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (FJMemberHeadViewfj *)headView{
    if(!_headView){
        _headView = NSMainBundleClass(FJMemberHeadViewfj.class);
    }
    return _headView;
}

- (FJMemberLevelViewfj *)levelView{
    if(!_levelView){
        _levelView = [FJMemberLevelViewfj new];
    }
    return _levelView;
}

- (CTMemberEquityView *)equityView{
    if(!_equityView){
        _equityView = [CTMemberEquityView new];
    }
    return _equityView;
}

- (CTMemberPrivilegeView *)privilegeView{
    if(!_privilegeView){
        _privilegeView = [CTMemberPrivilegeView new];
    }
    return _privilegeView;
}
- (FJMemberUpgradeViewfj *)upgradeView{
    if(!_upgradeView){
        _upgradeView = [FJMemberUpgradeViewfj new];
    }
    return _upgradeView;
}

- (FJMemberChoicenessViewfj *)choicenessView{
    if(!_choicenessView){
        _choicenessView = [FJMemberChoicenessViewfj new];
    }
    return _choicenessView;
}

- (FJMemberStrategyViewfj *)strategyView{
    if(!_strategyView){
        _strategyView = [FJMemberStrategyViewfj new];
    }
    return _strategyView;
}


- (void)setUpUI{
    self.title = @"会员中心";
    self.hideSystemNavBarWhenAppear = YES;
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.navBar];
    
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
}
- (void)request{
    [CTRequest fj_userIndexWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.containerView.tableView endRefreshing];
        if(!error){
            self.model = [CTMemberInfoModel yy_modelWithDictionary:data];
            self.headView.user = self.model.user;
            self.levelView.level = self.model.user.level;
            self.equityView.models = self.model.user_rebate;
            self.privilegeView.models = self.model.grade_power;
            self.upgradeView.containerView.titleLabel.text = self.model.upgrade_condition.txt1;
            self.upgradeView.containerView.mainConditionLabel.text = self.model.upgrade_condition.txt2;
            self.upgradeView.containerView.subConditionLabel.text = self.model.upgrade_condition.txt3;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadView];
            });
        }
    }];
}
- (void)reloadView{
    [self.containerView removeAllObjects];

    @weakify(self)
    //头部视图
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        UIView *section1 = [UIView new];
        [section1 addSubview:self.headView];
        [section1 addSubview:self.levelView];
        
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(188 + NAVBAR_TOP);
        }];
        [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(90);
            make.bottom.mas_equalTo(0);
        }];
        config.sectioView = section1;
        config.sectionHeight = 215;
        config.space = 20;
     
    }];
    //我的权益
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.equityView;
        
        config.sectionHeight = [self.equityView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
    }];
    //我的特权
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.privilegeView;
        
        config.sectionHeight = [self.privilegeView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
        config.space = 20;
    }];
    //升级条件
    [self.containerView addConfig:self.model.showUpgrade?^(CLSectionConfig *config) {
        @strongify(self)

        config.sectioView = self.upgradeView;
        config.sectionHeight = [self.upgradeView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
        config.space = 30;
    }:nil];
    //会员精选
    if(self.model.advs.count){
        [self.containerView addConfig:^(CLSectionConfig *config) {
            @strongify(self)
            config.sectioView = self.choicenessView;
            self.choicenessView.imgs = [self.model.advs map:^id(NSInteger index, CTActivityModel *element) {
                return element.img?:@"";
            }];
            config.sectionHeight = [self.choicenessView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
            config.space = 20;
        }];
    }
   
    //赚钱攻略
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.strategyView;
        config.sectionHeight = [self.strategyView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
        config.space = 20;
    }];
    
 
}


- (void)setUpEvent{
    @weakify(self)
    [self.containerView.tableView addHeaderRefreshWithCallBack:^{
        @strongify(self);
        [self request];
    }];
    [self.navBar.backButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self back];
    }];
    //会员权益
    [self.headView.equityBackgroundView addActionWithBlock:^(id target) {
        @strongify(self)
        FJMemberEquityControllerfj *vc =  [FJMemberEquityControllerfj new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //奖金攻略
    [self.strategyView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        NSArray *urls = @[CTH5UrlForType(CTH5UrlMakeMoneyStrategy),CTH5UrlForType(CTH5UrlSaveMoneyStrategy)];
        UIViewController *webVc = [[CTModuleManager webService]fj_pushWebFromViewController:self url:urls[index]];
        webVc.title = self.strategyView.titles[index];
    }];
    [self.choicenessView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        [CTModuleHelper showCtVcFromViewController:self model:self.model.advs[index]];
    }];
    
    //scrollView偏移导航效果
    [self.containerView setScrollBlock:^(CGPoint contentOffest) {
        @strongify(self)
        CGFloat startOffest = 100;
        CGFloat alpha = 0;
        if(contentOffest.y > startOffest){
           alpha = (contentOffest.y - startOffest)/80;
        }
        else{
            alpha = 0;
        }
        self.navBar.alpha = alpha;
    }];
    //登录注册后刷新
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:CTDidLoginNotification object:nil]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self request];
    }];
}
@end
