//
//  UIUtil.h
//  YMKMain
//
//  Created by dengchenglin on 2018/7/9.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIUtil : NSObject

+ (UIScrollView *)getSuperScrollViewWithView:(UIView *)view;

+ (UIViewController *)getSuperViewControllerWithView:(UIView *)view;

+ (UIViewController *)getCurrentViewController;

@end
