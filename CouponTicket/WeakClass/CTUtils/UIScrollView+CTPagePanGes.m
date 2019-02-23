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
             return YES;
        }
    }
    return NO;
}


@end
