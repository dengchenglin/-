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

@interface CTMemberViewController ()

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
    self.hideSystemNavBarWhenAppear = YES;
    [self.view addSubview:self.containerView];

}

- (void)autoLayout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
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
            make.height.mas_equalTo(188);
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
    //会员精选
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.choicenessView;
        self.choicenessView.imgs = @[@"",@"",@""];
        config.sectionHeight = [self.choicenessView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
        config.space = 20;
    }];
    [self.containerView addConfig:^(CLSectionConfig *config) {
        @strongify(self)
        config.sectioView = self.strategyView;
        self.strategyView.models = @[@"",@""];
        config.sectionHeight = [self.strategyView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
        config.space = 20;
    }];
}
@end
