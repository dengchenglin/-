//
//  CLRefreshNulMoreView.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/3.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshNulMoreView.h"

@implementation CLRefreshNulMoreView
{
    UILabel *_label;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    _label = [[UILabel alloc]init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:15];
    _label.text = @"没有更多啦!";
    _label.textColor = [UIColor grayColor];

    [self addSubview:_label];
}

- (void)layoutSubviews{
    [_label setFrame:self.bounds];
}

@end
