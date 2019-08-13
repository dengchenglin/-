//
//  CTMemberUpgradeView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "FJMemberUpgradeViewfj.h"

@implementation FJMemberUpgradeViewfj

ViewInstance(setUp)

- (void)setUp{
    _titleView = NSMainBundleClass(FJMemberTitleView.class);
    _titleView.titleLabel.text = @"升级条件";
    [self addSubview:_titleView];
    
    _containerView = NSMainBundleClass(CTMemberUpgradeContainerView.class);
    [self addSubview:_containerView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.right.left.bottom.mas_equalTo(0);
    }];
}

@end
