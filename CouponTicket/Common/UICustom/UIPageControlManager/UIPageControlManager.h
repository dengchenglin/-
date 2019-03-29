//
//  UIPageControlManager.h
//  SegmentedControlViewController
//
//  Created by peikua on 16/11/18.
//  Copyright © 2016年 peikua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIPageControlManager;

@protocol UIPageControlManagerDelegate <NSObject>

@optional
//SegmentedControl被点击

- (void)didClickSegmentedControlWithIndex:(NSInteger)index pageControlManager:(UIPageControlManager *)pageControlManager;

//pageViewController被滑动

- (void)didTransitionToIndex:(NSInteger)index pageControlManager:(UIPageControlManager *)pageControlManager;

@end

@protocol UIPageControlManagerDataSoure <NSObject>

@required

- (NSArray <UIViewController *> *)viewControllersWithPageControlManager:(UIPageControlManager *)pageControlManager;

@optional

- (CGRect)rectForSegmentedControlWithPageControlManager:(UIPageControlManager *)pageControlManager;

- (CGRect)rectForPageViewControllerWithPageControlManager:(UIPageControlManager *)pageControlManager;

- (CGSize)sizeForSegmentedControlAtIndex:(NSInteger)index;

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndex:(NSInteger)index;
@end


@interface UIPageControlManager : NSObject

@property (nonatomic, strong) UICollectionView *segmentedControlView;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic,   weak) UIViewController *viewController;

@property (nonatomic,   copy) NSArray <UIViewController *>* viewControllers;

@property (nonatomic,   weak) id <UIPageControlManagerDelegate>delegate;

@property (nonatomic,   weak) id <UIPageControlManagerDataSoure> datasoure;

@property (nonatomic, assign) CGRect segmentedControlRect;

@property (nonatomic, assign) CGRect pageViewControllerFrame;

@property (nonatomic, assign) CGSize segmentedControlItemSize;


- (instancetype)initWithViewController:(UIViewController *)viewController;

- (void)reloadData;

- (void)scrollPageToIndex:(NSInteger)index;

- (void)scrollPageToIndex:(NSInteger)index animated:(BOOL)animated;

@end

