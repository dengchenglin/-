
//
//  UIUtil.m
//  YMKMain
//
//  Created by dengchenglin on 2018/7/9.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "UIUtil.h"

@implementation UIUtil

+ (UIScrollView *)getSuperScrollViewWithView:(UIView *)view{
    if([[view nextResponder] isKindOfClass:[UIScrollView class]] || [view nextResponder] == nil){
        return (UIScrollView *)[view nextResponder];
    }
    return [UIUtil getSuperScrollViewWithView:view.superview];
}

+ (UIViewController *)getSuperViewControllerWithView:(UIView *)view{
    if([[view nextResponder] isKindOfClass:[UIViewController class]] || [view nextResponder] == nil){
        return (UIViewController *)[view nextResponder];
    }
    return [UIUtil getSuperViewControllerWithView:view.superview];
}

+ (UIViewController *)getCurrentViewController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        //多层present
        while (appRootVC.presentedViewController) {
            appRootVC = appRootVC.presentedViewController;
            if (appRootVC) {
                nextResponder = appRootVC;
            }else{
                break;
            }
        }
        //        nextResponder = appRootVC.presentedViewController;
    }else if(window.subviews.count > 0){
        
        //        NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    if(![nextResponder isKindOfClass:UIViewController.class]){
        return nil;
    }
    else{
        result = [self getTopWithViewController:nextResponder];
    }
    return result;
}

+ (UIViewController *)getTopWithViewController:(UIViewController *)viewController{
    if([viewController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tab = (UITabBarController *)viewController;
        if(tab.viewControllers){
            UIViewController *vc = [self getTopWithViewController:tab.viewControllers[tab.selectedIndex]];
            return vc;
        }
    }
    else if([viewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)viewController;
        if(nav.viewControllers){
            UIViewController *vc = [self getTopWithViewController:nav.viewControllers.lastObject];
            return vc;
        }
    }
    return viewController;
}

@end
