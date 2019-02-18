//
//  CTMemverViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMemberViewController.h"

#import "CLContainerView.h"

#import "CTMemberHeadView.h"

#import "CTMemberLevelView.h"

#import "CTMemberEquityView.h"

#import "CTMemberPrivilegeView.h"

#import "CTMemberUpgradeView.h"

#import "CTMemberChoicenessView.h"

#import "CTMemberStrategyView.h"

#import "CTNavBar.h"

#import "CTMemberEquityController.h"

@interface CTMemberViewController ()

@property (nonatomic, strong) CTNavBar *navBar;

@property (nonatomic, strong) CLContainerView *containerView;

@property (nonatomic, strong) CTMemberHeadView *headView;

@property (nonatomic, strong) CTMemberLevelView *levelView;

@property (nonatomic, strong) CTMemberEquityView *equityView;

@property (nonatomic, strong) CTMemberPrivilegeView *privilegeView;

@property (nonatomic, strong) CTMemberUpgradeView *upgradeView;

@property (nonatomic, strong) CTMemberChoicenessView *choicenessView;

@property (nonatomic, strong) CTMemberStrategyView *strategyView;

@end

@implementation CTMemberViewController

- (CTNavBar *)navBar{
    if(!_navBar){
        _navBar = NSMainBundleClass(CTNavBar.class);
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

- (CTMemberHeadView *)headView{
    if(!_headView){
        _headView = NSMainBundleClass(CTMemberHeadView.class);
    }
    return _headView;
}

- (CTMemberLevelView *)levelView{
    if(!_levelView){
        _levelView = [CTMemberLevelView new];
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
- (CTMemberUpgradeView *)upgradeView{
    if(!_upgradeView){
        _upgradeView = [CTMemberUpgradeView new];
    }
    return _upgradeView;
}

- (CTMemberChoicenessView *)choicenessView{
    if(!_choicenessView){
        _choicenessView = [CTMemberChoicenessView new];
    }
    return _choicenessView;
}

- (CTMemberStrategyView *)strategyView{
    if(!_strategyView){
        _strategyView = [CTMemberStrategyView new];
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadView];
    });
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
        self.levelView.level = CTMemberPartner;
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
        self.equityView.models = @[@"",@"",@"",@""];
        config.sectionHeight = [self.equityView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
    }];
    //我的特权
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.privilegeView;
        self.privilegeView.models = @[@"",@"",@"",@"",@"",@"",@"",@""];
        config.sectionHeight = [self.privilegeView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
        config.space = 20;
    }];
    //升级条件
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.upgradeView;
        config.sectionHeight = [self.upgradeView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
        config.space = 30;
    }];
//    //会员精选
//    [self.containerView addConfig:^(CLSectionConfig *config) {
//        @strongify(self)
//        config.sectioView = self.choicenessView;
//        self.choicenessView.imgs = @[@"",@"",@""];
//        config.sectionHeight = [self.choicenessView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
//        config.space = 20;
//    }];
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

    //会员权益
    [self.headView.equityBackgroundView addActionWithBlock:^(id target) {
        @strongify(self)
        CTMemberEquityController *vc =  [CTMemberEquityController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //奖金攻略
    [self.strategyView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        UIViewController *webVc = [[CTModuleManager webService]pushWebFromViewController:self url:nil];
        webVc.title = self.strategyView.titles[index];
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
}
@end
