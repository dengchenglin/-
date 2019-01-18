//
//  CLRefreshConfig.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshConfig.h"

CGFloat const CLRefreshingDistance = 100.0f;

CGFloat const CLRefreshLoadMoreDistance = 60.0f;

@implementation CLRefreshConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _refreshDistance = CLRefreshingDistance;
        _loadMoreDistance = CLRefreshLoadMoreDistance;
    }
    return self;
}

@end
