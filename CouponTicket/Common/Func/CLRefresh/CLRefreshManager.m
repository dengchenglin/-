//
//  CLRefreshManager.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshManager.h"

#import "CLRefreshFactory.h"

@implementation CLRefreshManager
static CLRefreshManager *manager;
+ (instancetype)shareInsatnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CLRefreshManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _config = [[CLRefreshConfig alloc]init];
    }
    return self;
}

+ (CLRefreshHeader *)createHeaderWithScrollView:(UIScrollView *)scrollView{
    return [CLRefreshFactory createHeaderWithType:[CLRefreshManager shareInsatnce].config.headerType scrollView:scrollView];
}

+ (CLRefreshFooter *)createFooterWithScrollView:(UIScrollView *)scrollView{
    return [CLRefreshFactory createFooterWithType:[CLRefreshManager shareInsatnce].config.footerType scrollView:scrollView];
}

@end
