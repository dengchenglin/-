//
//  CLRefreshHeader.h
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLRefreshHeader : UIView

@property (nonatomic, weak, readonly)UIScrollView *scrollView;

@property (nonatomic, copy) void (^refreshBlock)(void);

//progress/loading/diff 自定义动画子视图时重写这些属性完成相应的UI效果
//下拉进度
@property (nonatomic, assign)CGFloat progress;
//触发加载
@property (nonatomic, assign)BOOL loading;
//滑到触发加载的距离后继续滑动的偏移距离
@property (nonatomic, assign)CGFloat diff;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

/**
 *  立即触发下拉刷新
 */
- (void)beginRefreshing;

/**
 *  结束刷新
 */
- (void)endRefreshing;


@end
