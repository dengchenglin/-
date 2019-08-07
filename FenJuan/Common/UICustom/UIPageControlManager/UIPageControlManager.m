//
//  UIPageControlManager.m
//  SegmentedControlViewController
//
//  Created by peikua on 16/11/18.
//  Copyright © 2016年 peikua. All rights reserved.
//

#import "UIPageControlManager.h"

@interface UIPageControlManager ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation UIPageControlManager
@synthesize  segmentedControlRect = _segmentedControlRect;
@synthesize  pageViewControllerFrame = _pageViewControllerFrame;
@synthesize  viewControllers = _viewControllers;

- (instancetype)initWithViewController:(UIViewController *) viewController{
    if(self = [super init]){
        self.viewController = viewController;
        viewController.automaticallyAdjustsScrollViewInsets = NO;
        self.segmentedControlRect = CGRectZero;
        self.segmentedControlItemSize = CGSizeZero;
        self.pageViewControllerFrame = CGRectMake(0, 0, viewController.view.bounds.size.width,viewController.view.bounds.size.height);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0.0;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.segmentedControlView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.segmentedControlView.bounces = NO;
    self.segmentedControlView.backgroundColor = [UIColor clearColor];
    self.segmentedControlView.showsHorizontalScrollIndicator = NO;
    self.segmentedControlView.delegate = self;
    self.segmentedControlView.dataSource = self;
    [self.viewController.view addSubview:_segmentedControlView];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [self.viewController addChildViewController:_pageViewController];
    [self.viewController.view insertSubview:_pageViewController.view atIndex:0];
    [self reloadData];
}

- (void)setSegmentedControlRect:(CGRect)segmentedControlRect{
    _segmentedControlRect = segmentedControlRect;
    [self layoutView];
}

- (CGRect)segmentedControlRect{
    if(_datasoure && [_datasoure respondsToSelector:@selector(rectForSegmentedControlWithPageControlManager:)]){
        
        _segmentedControlRect = [_datasoure rectForSegmentedControlWithPageControlManager:self];
        
    }
    return _segmentedControlRect;
}

- (void)setPageViewControllerFrame:(CGRect)pageViewControllerFrame{
    _pageViewControllerFrame = pageViewControllerFrame;
    [self layoutView];
}


- (CGRect)pageViewControllerFrame{
    if(_datasoure && [_datasoure respondsToSelector:@selector(rectForPageViewControllerWithPageControlManager:)]){
        
        _pageViewControllerFrame = [_datasoure rectForPageViewControllerWithPageControlManager:self];
        
    }
    return _pageViewControllerFrame;
}



- (NSArray<UIViewController *> *)viewControllers{
    if(_datasoure && [_datasoure respondsToSelector:@selector(viewControllersWithPageControlManager:)]){
        
        _viewControllers = [_datasoure viewControllersWithPageControlManager:self];
        
    }
    return _viewControllers;
}




- (void)layoutView{
    [self.segmentedControlView setFrame:self.segmentedControlRect];
    [self.pageViewController.view setFrame:self.pageViewControllerFrame];
}

- (void)reloadData{
    if(self.viewControllers.count){
        [self.pageViewController setViewControllers:@[self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self.viewController addChildViewController:self.pageViewController];
        [self.viewController.view insertSubview:_pageViewController.view atIndex:0];
    }
    else{
        [self.pageViewController.view removeFromSuperview];
        [self.pageViewController removeFromParentViewController];
    }
    [self layoutView];
    [self.segmentedControlView reloadData];
}


#pragma mark -SegmentedControlViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.frame.size.width == 0 || collectionView.frame.size.height == 0){
      return 0;
    }
    return self.viewControllers.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_datasoure && [_datasoure respondsToSelector:@selector(sizeForSegmentedControlAtIndex:)]){
        return [_datasoure sizeForSegmentedControlAtIndex:indexPath.row];
    }
    return _segmentedControlItemSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [_datasoure collectionView:collectionView cellForItemAtIndex:indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self scrollPageToIndex:indexPath.row];
    if(_delegate && [_delegate respondsToSelector:@selector(didClickSegmentedControlWithIndex:pageControlManager:)]){
        [_delegate didTransitionToIndex:indexPath.row pageControlManager:self];
    }
}

#pragma mark - PageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if(index == NSNotFound){
        return nil;
    }
    index ++;
    if(index < self.self.viewControllers.count){
        return [self.viewControllers objectAtIndex:index];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    
    if(index == 0 || index == NSNotFound){
        return nil;
    }
    index --;
    return [self.viewControllers objectAtIndex:index];
}

- (void)scrollPageToIndex:(NSInteger)index{
    
    [self scrollPageToIndex:index animated:YES];
    
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed && finished){
        NSInteger index = [self.viewControllers indexOfObject:[pageViewController.viewControllers objectAtIndex:0]];
        if(_delegate && [_delegate respondsToSelector:@selector(didTransitionToIndex:pageControlManager:)]){
            [_delegate didTransitionToIndex:index pageControlManager:self];
        }
    }
}

- (void)scrollPageToIndex:(NSInteger)index animated:(BOOL)animated{
    NSInteger currentIndex = [self.viewControllers indexOfObject:self.pageViewController.viewControllers[0]];
    if(currentIndex != NSNotFound){
        if(currentIndex > index){
            [self.pageViewController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:animated completion:nil];
        }
        else{
            [self.pageViewController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:nil];
        }
        
    }
}

@end
