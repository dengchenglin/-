//
//  CTNestPageController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

@protocol CTNestSubControllerProtocol<NSObject>

@property (nonatomic, weak) id<UIScrollViewDelegate> delegate;

- (UIScrollView *)nestScrollView;

@end

@protocol CTNestPageControllerDataSoure<NSObject>

@required

- (NSArray <CTNestSubControllerProtocol,UIScrollViewDelegate>*)viewControllers;

- (CGFloat)heightForHeadView;

- (UIView *)headView;

- (CGFloat)heightForSuspendView;

- (UIView *)suspendView;

@optional

- (BOOL)ignoreNavBar;

- (void)pageViewControllerDidScrollToIndex:(NSInteger)index;

@end

@interface CTNestPageController : CTBaseViewController<CTNestPageControllerDataSoure,UIScrollViewDelegate>

- (void)pageViewControllerScrollToIndex:(NSInteger)index;

@end
