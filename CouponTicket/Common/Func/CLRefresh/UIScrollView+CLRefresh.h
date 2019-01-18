//
//  UIScrollView+CLRefresh.h
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CLRefresh)

- (void)addHeaderRefreshWithCallBack:(void(^)(void))callBack;

- (void)addFooterRefreshWithCallBack:(void(^)(void))callBack;

- (void)beginRefreshing;

- (void)endRefreshing;

- (void)showNulMoreView;

- (void)hiddenNulMoreView;

@end
