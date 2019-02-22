//
//  CTPageController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

@class CTPageController;

@protocol CTPageControllerDelegate

- (void)scrollToIndex:(NSInteger)index;

- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index;

@end

@interface CTPageController : CTBaseViewController <CTPageControllerDelegate>

@property (nonatomic,strong) UIPageViewController *pageController;

@property (nonatomic, copy)NSArray<UIViewController *>*viewControllers;

@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, assign) NSInteger toIndex;

@property (nonatomic, assign) NSInteger currentIndex;

@end
