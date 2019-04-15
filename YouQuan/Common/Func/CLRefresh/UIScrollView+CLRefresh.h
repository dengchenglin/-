//
//  UIScrollView+CLRefresh.h
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CLRefreshHeader.h"

#import "CLRefreshFooter.h"

@interface UIScrollView (CLRefresh)

- (CLRefreshHeader *)addHeaderRefreshWithCallBack:(void(^)(void))callBack;

- (CLRefreshFooter *)addFooterRefreshWithCallBack:(void(^)(void))callBack;

- (void)beginRefreshing;

- (void)endRefreshing;

- (void)showNulMoreView;

- (void)hiddenNulMoreView;

@end
