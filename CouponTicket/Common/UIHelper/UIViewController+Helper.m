
//
//  UIViewController+Helper.m
//  LightMaster
//
//  Created by Dankal on 2018/12/30.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import "UIViewController+Helper.h"

#import <objc/runtime.h>

#import "NSObject+YYAdd.h"

static const int WillPopKey;

static const int IsPopKey;

@implementation UIViewController (Helper)

+ (void)load{
    [self swizzleInstanceMethod:@selector(viewWillDisappear:) with:@selector(cl_viewWillDisappear:)];
    [self swizzleInstanceMethod:@selector(viewDidAppear:) with:@selector(cl_viewDidAppear:)];
}

- (void)setIsPop:(BOOL)isPop{
    objc_setAssociatedObject(self, &IsPopKey, @(isPop), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)isPop{
    return [objc_getAssociatedObject(self, &IsPopKey) boolValue];
}

- (void)cl_viewWillDisappear:(BOOL)animated{
    [self cl_viewWillDisappear:animated];
    if(self.navigationController.viewControllers.count > 1 || self.presentedViewController){
        self.isPop = YES;
    }
    else{
        self.isPop = NO;
    }
    
}

- (void)cl_viewDidAppear:(BOOL)animated{
    [self cl_viewDidAppear:animated];
    self.isPop = NO;
}


- (void)setWillPop:(BOOL)willPop{
     objc_setAssociatedObject(self, &WillPopKey, @(willPop), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)willPop{
    id value = objc_getAssociatedObject(self, &WillPopKey);
    return [value boolValue];
  
}


@end

@implementation UINavigationController (Helper)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(popToViewController:animated:) with:@selector(cl_popToViewController:animated:)];
        [self swizzleInstanceMethod:@selector(popViewControllerAnimated:) with:@selector(cl_popViewControllerAnimated:)];
         [self swizzleInstanceMethod:@selector(popToRootViewControllerAnimated:) with:@selector(cl_popToRootViewControllerAnimated:)];
    });
}
- (nullable NSArray<__kindof UIViewController *> *)cl_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *vc = viewController.navigationController.viewControllers.lastObject;
    vc.willPop = YES;
    return [self cl_popToViewController:viewController animated:animated];
}
- (UIViewController *)cl_popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = self.viewControllers.lastObject;
    vc.willPop = YES;
    return [self cl_popViewControllerAnimated:animated];
}
- (NSArray<UIViewController *> *)cl_popToRootViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = self.viewControllers.lastObject;
    vc.willPop = YES;
    return [self cl_popToRootViewControllerAnimated:animated];
}



@end
