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

@interface CTMemberViewController ()

@property (nonatomic, strong) CLContainerView *containerView;

@property (nonatomic, strong) CTMemberHeadView *headView;

@property (nonatomic, strong) CTMemberLevelView *levelView;

@end

@implementation CTMemberViewController

- (CLContainerView *)containerView{
    if(!_containerView){
        _containerView = [[CLContainerView alloc]init];
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

- (void)setUpUI{
    self.hideSystemNavBarWhenAppear = YES;
    [self.view addSubview:self.containerView];

}

- (void)autoLayout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)reloadView{
    [self.containerView removeAllObjects];
    @weakify(self)
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
    }];
}
@end
