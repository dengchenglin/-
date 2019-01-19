//
//  CTHomeTopView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeTopView.h"

@interface CTHomeTopView()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CTHomeTopView

ViewInstance(setUp)

- (void)setUp{
    [self setUpUI];
    [self autoLayout];
    [self setUpEvent];
}
- (void)setUpUI{
    _containerView = [UIView new];
    _containerView.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_nav_bg"].CGImage;
    [self addSubview:_containerView];
    
    _navBar = NSMainBundleName(CTHomeNavBar.class);
    [_containerView addSubview:_navBar];
    
    _categoryControl = [[CTMainCategoryControl alloc]init];
    _categoryControl.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_categoryControl];
}
- (void)autoLayout{
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT);

    }];
    [_categoryControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.bottom.left.right.mas_equalTo(0);
    }];
}
- (void)setUpEvent{
    
}

@end
