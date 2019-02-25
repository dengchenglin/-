//
//  CTPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPageController.h"

@interface CTPageController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation CTPageController

- (UIPageViewController *)pageController{
    if(!_pageController){
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
        _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageController.dataSource = self;
        _pageController.delegate = self;
        
    }
    return _pageController;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    __block UIScrollView *scrollView = nil;

  
}



- (void)setContentInsets:(UIEdgeInsets)contentInsets{
    _contentInsets = contentInsets;
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(contentInsets);
    }];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers{
    _viewControllers = [viewControllers copy];
    if(!_viewControllers.count)return;
    if(_toIndex > _viewControllers.count - 1){
        _toIndex = 0;
    }
    UIViewController *firstVc = self.viewControllers[_toIndex];
    
    if(_viewControllers.count){
        [self.pageController setViewControllers:@[firstVc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    else{
        [self.pageController setViewControllers:@[[UIViewController new]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    [self pageController:self didScrollToIndex:_toIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if(index == NSNotFound){
        return nil;
    }
    index ++;
    if(index < self.viewControllers.count){
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
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed && finished){
        NSInteger index = [_viewControllers indexOfObject:[pageViewController.viewControllers objectAtIndex:0]];
        [self pageController:self didScrollToIndex:index];
    }
}

- (void)scrollToIndex:(NSInteger)index{
    NSInteger currentIndex = [self.viewControllers indexOfObject:_pageController.viewControllers[0]];
    if(currentIndex != NSNotFound){
        if(currentIndex > index){
            [_pageController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        }
        else{
            [_pageController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
    }
}
- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    
}
@end
