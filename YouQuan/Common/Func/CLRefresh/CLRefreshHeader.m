//
//  CLRefreshHeader.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshHeader.h"

#import "CLRefreshManager.h"

NSString *const CLRefreshKeyPathContentOffset = @"contentOffset";

@implementation CLRefreshHeader
{
    __weak UIScrollView *_scrollView;

    CGFloat _refreshDistance;
    UIEdgeInsets _originEdgeInsets;
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView{
    if(self = [super init]){
        _scrollView = scrollView;
        [_scrollView insertSubview:self atIndex:0];
        
        _refreshDistance = [CLRefreshManager shareInsatnce].config.refreshDistance;
        _originEdgeInsets = _scrollView.contentInset;
        if([_scrollView isKindOfClass:[UITableView class]]){
            UITableView *tableView = (UITableView *)_scrollView;
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self.superview removeObserver:self forKeyPath:CLRefreshKeyPathContentOffset];

    if(newSuperview){
        [newSuperview addObserver:self forKeyPath:CLRefreshKeyPathContentOffset options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:CLRefreshKeyPathContentOffset]) {
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (contentOffset.y  < 0) {
            CGFloat progress = MAX(0.0, MIN(fabs(contentOffset.y)/_refreshDistance, 1.2));
            if(!_loading){
                self.progress = progress;
            }
            if(self.progress >= 1.0 && !self.scrollView.isDragging && !self.loading){
                self.loading = YES;
                [UIView animateWithDuration:0.3 animations:^{
                    self.scrollView.contentInset = UIEdgeInsetsMake(self.bounds.size.height, 0, 0, 0);
                }];
                if(self.refreshBlock){
                    self.refreshBlock();
                }
            }
            CGFloat diff = fabs(self.scrollView.contentOffset.y) - _refreshDistance;
            if(diff > 0 && !_loading){
                self.diff = diff;
            }

        }
    }

}

- (void)beginRefreshing{
    [self.scrollView setContentOffset:CGPointMake(0,  -_refreshDistance) animated:YES];
}

- (void)endRefreshing{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.contentInset = self->_originEdgeInsets;
    } completion:^(BOOL finished) {
        self.loading = NO;
    }];
}

@end
