//
//  CTMemberStrategyView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "FJMemberStrategyViewfj.h"

#import "FJMemberStrategyItemfj.h"

@interface FJMemberStrategyViewfj ()

@property (nonatomic, strong) UIView *containerView;


@end

@implementation FJMemberStrategyViewfj

ViewInstance(setUp)

- (void)setUp{
    _titleView = NSMainBundleClass(FJMemberTitleView.class);
    _titleView.titleLabel.text = @"奖金攻略";
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
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.bottom.mas_equalTo(0);
    }];
    
    self.titles = @[@"赚钱攻略",@"省钱攻略"];
    [self reloadView];
}

- (void)reloadView{
    NSArray *imgs = @[@"i_make_money",@"i_save_money"];
    CGFloat containerWidth = _containerView.width;
    if(!containerWidth)containerWidth = SCREEN_WIDTH - 60;
    NSInteger lineCount = (_titles.count<4?_titles.count:4);
    CGFloat itemWidth = containerWidth/lineCount;
    CGFloat itemHeight = 90;
    NSInteger count = _titles.count;
    
    for(int i = 0;i < count;i ++){
        FJMemberStrategyItemfj *item = NSMainBundleClass(FJMemberStrategyItemfj.class);
        item.title = _titles[i];
        item.imageView.image = [UIImage imageNamed:imgs[i]];
        item.tag = 100 + i;
        [_containerView addSubview:item];
        CGFloat left = (i%lineCount) * itemWidth;
        CGFloat top = (i/lineCount) * itemHeight;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.top.mas_equalTo(top);
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemHeight);
        }];
        @weakify(self)
        [item addActionWithBlock:^(UIView *target) {
            @strongify(self)
            if(self.clickItemBlock){
                self.clickItemBlock(target.tag - 100);
            }
        }];
    }
    CGFloat totalHeight = (count + lineCount - 1)/lineCount * itemHeight;
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(totalHeight);
    }];
}

@end
