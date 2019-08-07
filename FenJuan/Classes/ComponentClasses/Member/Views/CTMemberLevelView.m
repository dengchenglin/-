//
//  CTMemberLevelView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMemberLevelView.h"

@interface CTMemberLevelProgressView: UIView

@property (nonatomic, assign) CTMemberLevel level;

@end

@implementation CTMemberLevelProgressView

- (void)setLevel:(CTMemberLevel)level{
    _level = level;
    [self reloadView];
}

- (void)reloadView{
    [self removeAllSubViews];
    int count = (_level == CTMemberPartner?4:3);
    
    UIView *tempView;
    for(int i = 0; i < count;i ++){
        UIView *view = [UIView new];
        view.tag = 100 + i;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if(tempView){
                make.left.mas_equalTo(tempView.mas_right);
                make.width.mas_equalTo(tempView.mas_width);
            }
            else{
                make.left.mas_equalTo(0);
            }
            if(i == count - 1){
                make.right.mas_equalTo(0);
            }
            make.top.bottom.mas_equalTo(0);
        }];
        tempView = view;
    }
    
    CGSize logoSize = CGSizeMake(14, 14);
    for(int i = 0;i < count;i ++){
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"i_vip_level"]];
        imageView.tag = 200 + i;
        imageView.hidden = (i>_level-1);
        [self addSubview:imageView];
        UIView *referView = [self viewWithTag:100 + i];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(logoSize);
            make.centerX.mas_equalTo(referView.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    
    UIView *firstView = [self viewWithTag:200];

    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = RGBColor(51, 51, 51);
    [self addSubview:backgroundView];
    UIView *lastView = [self viewWithTag:200 + count - 1];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstView.mas_left).offset(logoSize.width/2);
        make.right.mas_equalTo(lastView.mas_left).offset(logoSize.width/2);
        make.height.mas_equalTo(4);
        make.centerY.mas_equalTo(self.centerY);
    }];

    
    UIView *hidhbackgroundView = [UIView new];
    hidhbackgroundView.backgroundColor = RGBColor(231, 208, 153);
    [self addSubview:hidhbackgroundView];
    UIView *rightView = [self viewWithTag:200 + _level - 1];
    [hidhbackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstView.mas_left).offset(logoSize.width/2);
        make.right.mas_equalTo(rightView.mas_left).offset(logoSize.width/2);
        make.height.mas_equalTo(4);
        make.centerY.mas_equalTo(self.centerY);
    }];

    for(int i = 0;i < count;i ++){
        UIView *imageView = [self viewWithTag:200 + i];
        [self addSubview:imageView];
   
    }
  
}

@end

@interface CTMemberLevelTitleView:UIView

@property (nonatomic, copy) NSArray <NSString *>*titles;

@end

@implementation CTMemberLevelTitleView

- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = [titles copy];
    UIView *leftView;
    for(int i = 0; i < _titles.count;i ++){
        UILabel *label = [[UILabel alloc]init];
        label.text = _titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = RGBColor(234, 211, 155);
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if(leftView){
                make.left.mas_equalTo(leftView.mas_right);
                make.width.mas_equalTo(leftView.mas_width);
            }
            else{
                make.left.mas_equalTo(0);
            }
            if(i == self.titles.count - 1){
                make.right.mas_equalTo(0);
            }
            make.top.bottom.mas_equalTo(0);
        }];
        leftView = label;
    }
    
}

@end

@interface CTMemberLevelView()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CTMemberLevelView

ViewInstance(setUp)

- (void)setUp{
    self.layer.cornerRadius = 8;
    self.clipsToBounds = YES;
    UIImage *backgroundImage = [UIImage imageNamed:@"pic_bg_vip_level"];
    UIImageView *backgoundView = [[UIImageView alloc]initWithImage:backgroundImage];
    [self addSubview:backgoundView];
    [backgoundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _containerView = [UIView new];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(25);
        make.bottom.mas_equalTo(-20);
    }];
}

- (void)setLevel:(CTMemberLevel)level{
    _level = level;
    if(_level < 1 || _level > 4){
        return;
    }
    [self reloadView];
}
- (void)reloadView{
    [_containerView removeAllSubViews];
    NSArray *titles = @[@"粉券小生",@"粉券导师",@"粉券大咖"];
    if(_level == CTMemberPartner){
        titles = @[@"粉券小生",@"粉券导师",@"粉券大咖",@"粉券合伙人"];
    }
    CTMemberLevelTitleView *titleView = [CTMemberLevelTitleView new];
    titleView.titles = titles;
    [_containerView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(19);
        make.bottom.left.right.mas_equalTo(0);
    }];
    
    CTMemberLevelProgressView *progressView = [CTMemberLevelProgressView new];
    progressView.level = _level;
    [_containerView addSubview:progressView];
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(0);
    }];
    
}


@end
