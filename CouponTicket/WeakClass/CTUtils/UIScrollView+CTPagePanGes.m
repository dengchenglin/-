//
//  UIScrollView+CTPagePanGes.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "UIScrollView+CTPagePanGes.h"

@implementation UIScrollView (CTPagePanGes)

//解决CTPageController手势滑动冲突的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if([NSStringFromClass(gestureRecognizer.delegate.class) isEqualToString:@"_UIQueuingScrollView"]){
        if([otherGestureRecognizer.delegate isKindOfClass:UIViewController.class]){
            //当控制器是导航根控制器时不要返回YES,否则会导致push卡住
            UIViewController *vc = [UIUtil getCurrentViewController];
            if(vc.navigationController.viewControllers.count){
                if(vc.navigationController.viewControllers.firstObject == vc){
                    return NO;
                }
            }
             return YES;
        }
    }
    return NO;
}
@end
