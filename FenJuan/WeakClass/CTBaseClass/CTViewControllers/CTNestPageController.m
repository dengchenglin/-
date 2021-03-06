//
//  CTNestPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNestPageController.h"

@interface CTNestScrollView:UIScrollView<UIGestureRecognizerDelegate>
@end
@implementation CTNestScrollView
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if([NSStringFromClass([gestureRecognizer.delegate class]) isEqualToString:@"_UIQueuingScrollView"]){
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}

@end
@interface CTNestPageController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, strong) CTNestScrollView *scrollView;

@property (nonatomic,strong) UIPageViewController *pageController;

@property (nonatomic, weak) UIScrollView *currentSubScrollView;

@end

@implementation CTNestPageController

@synthesize scrollView = _scrollView;

- (UIPageViewController *)pageController{
    if(!_pageController){
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
        _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageController.dataSource = self;
        _pageController.delegate = self;
        [self addChildViewController:_pageController];
        [self.scrollView addSubview:_pageController.view];
    }
    return _pageController;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _scrollView = [[CTNestScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.alwaysBounceVertical = YES;
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_scrollView];

    if(self.headView){
        self.headView.frame = CGRectMake(0, 0, self.scrollView.width, self.heightForHeadView);
        [self.scrollView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.scrollView.width);
            make.height.mas_equalTo(self.heightForHeadView);
        }];
      
    }
    if(self.suspendView){
        [self.scrollView addSubview:self.suspendView];
        self.suspendView.frame = CGRectMake(0, self.headView.maxY, self.scrollView.width, self.heightForSuspendView);
    }
    [self addChildViewController:self.pageController];
    [self.scrollView addSubview:self.pageController.view];
     [self.pageController.view setFrame:CGRectMake(0,self.heightForHeadView+self.heightForSuspendView,self.scrollView.width,SCREEN_HEIGHT - self.heightForSuspendView - (self.ignoreNavBar?0:NAVBAR_HEIGHT))];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.pageController.view.frame));
    [self reloadPageController];
}

- (void)reloadPageController{
    
    if(self.viewControllers.count){
        for(id<CTNestSubControllerProtocol> protocol in self.viewControllers){
            protocol.delegate = self;
        }
        [self.pageController setViewControllers:@[self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        self.currentSubScrollView = [self.viewControllers[0] nestScrollView];
    }
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
        NSInteger index = [self.viewControllers indexOfObject:[pageViewController.viewControllers objectAtIndex:0]];
        [self pageViewControllerDidScrollToIndex:index];
        self.currentSubScrollView = [self.viewControllers[index] nestScrollView];
    }
}


- (void)pageViewControllerScrollToIndex:(NSInteger)index{
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

#pragma mark - CTNestPageControllerDataSoure

- (NSArray <CTNestSubControllerProtocol>*)viewControllers{
    return nil;
}

- (CGFloat)heightForHeadView{
    return 0;
}

- (UIView *)headView{
    return nil;
}

- (CGFloat)heightForSuspendView{
    return 0;
}

- (UIView *)suspendView{
    return nil;
}

- (BOOL)ignoreNavBar{
   return NO;
}

- (void)pageViewControllerDidScrollToIndex:(NSInteger)index{
    
}


//嵌套scrollView方案二
static BOOL canMainScroll = YES;
static BOOL canChildScroll = NO;

- (void)initialize{
    canMainScroll = YES;
    canChildScroll = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat maxOffest = self.heightForHeadView - (self.ignoreNavBar?0:NAVBAR_HEIGHT);
    
    if (scrollView == self.scrollView){
        if(!canMainScroll){
            self.scrollView.contentOffset = CGPointMake(0, maxOffest);
            canChildScroll = YES;
        }
        else if(scrollView.contentOffset.y >= maxOffest){
            self.scrollView.contentOffset = CGPointMake(0, maxOffest);
            canMainScroll = NO;
            canChildScroll = YES;
        }
    }
    else{
        if(!canChildScroll && self.currentSubScrollView.isDragging){
            self.currentSubScrollView.contentOffset = CGPointMake(-self.currentSubScrollView.contentInset.left, -self.currentSubScrollView.contentInset.top);
        }
        else if(scrollView.contentOffset.y <= -self.currentSubScrollView.contentInset.top){
            canChildScroll = NO;
            canMainScroll = YES;
            if(self.currentSubScrollView.isDragging){
                for( UIViewController <CTNestSubControllerProtocol> *vc in self.viewControllers){
                    if(vc.isViewLoaded){
                        UIScrollView *nestScrollView = [vc nestScrollView];
                        if(nestScrollView.contentOffset.y >= -nestScrollView.contentInset.top){
                            nestScrollView.contentOffset = CGPointMake(-nestScrollView.contentInset.left, -nestScrollView.contentInset.top);
                        }
                    }
                }
            }
        }
    }
    
}

//嵌套scrollView方案一

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat maxOffest = self.heightForHeadView - (self.ignoreNavBar?0:NAVBAR_HEIGHT);
//    //由于系统的contentOffset只精确到了一位 故这里也只能保留一位小数并且不能四舍五入
//    maxOffest = ((NSInteger)(maxOffest*10))/10.0;
//    if(scrollView == self.scrollView){
//        if(self.scrollView.contentOffset.y >= maxOffest){
//            self.scrollView.contentOffset = CGPointMake(0, maxOffest);
//        }
//        else if(self.scrollView.contentOffset.y < 0 && !self.scrollView.dragging && !self.scrollView.decelerating){
//            self.scrollView.contentOffset = CGPointZero;
//        }
//    }
//    else{
//        CGFloat offestY = scrollView.contentOffset.y + self.scrollView.contentOffset.y;
//
//        if(self.scrollView.contentOffset.y < maxOffest){
//            self.scrollView.contentOffset = CGPointMake(0, offestY);
//            if(scrollView.isDragging){
//                if(self.scrollView.contentOffset.y > 0 || scrollView.contentOffset.y > 0){
//                    scrollView.contentOffset = CGPointZero;
//                }
//            }
//        }
//        else if(scrollView.contentOffset.y < 0){
//            self.scrollView.contentOffset = CGPointMake(0, offestY);
//            for(UIViewController <CTNestSubControllerProtocol>*viewController in self.viewControllers){
//                if(viewController.isViewLoaded){
//                    viewController.nestScrollView.contentOffset = CGPointZero;
//                }
//            }
//        }
//        else if (scrollView.contentOffset.y == 0){
//            self.scrollView.contentOffset = CGPointMake(0, offestY);
//        }
//    }
//}



@end
