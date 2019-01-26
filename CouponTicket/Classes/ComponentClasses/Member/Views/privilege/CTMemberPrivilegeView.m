//
//  CTMemberPrivilegeView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTMemberPrivilegeView.h"

@interface CTMemberPrivilegeView()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CTMemberPrivilegeView

ViewInstance(setUp)

- (void)setUp{
    _titleView = NSMainBundleClass(CTMemberTitleView.class);
    _titleView.titleLabel.text = @"我的特权";
    [self addSubview:_titleView];
    
    _containerView = [UIView new];
    [self addSubview:_containerView];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setModels:(NSArray *)models{
    _models = [models copy];
    [self reloadView];
}

- (void)reloadView{
    CGFloat containerWidth = _containerView.width;
    if(!containerWidth)containerWidth = SCREEN_WIDTH - 20;
    NSInteger lineCount = (_models.count<4?_models.count:4);
    CGFloat itemWidth = containerWidth/lineCount;
    CGFloat itemHeight = 90;
    NSInteger count = _models.count;
    
    for(int i = 0;i < count;i ++){
        CTMemberPrivilegeItem *item = NSMainBundleClass(CTMemberPrivilegeItem.class);
        [_containerView addSubview:item];
        CGFloat left = (i%lineCount) * itemWidth;
        CGFloat top = (i/lineCount) * itemHeight;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.top.mas_equalTo(top);
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemHeight);
        }];
    }
    CGFloat totalHeight = (count + lineCount - 1)/lineCount * itemHeight;
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(totalHeight);
    }];
}
@end
