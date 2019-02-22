//
//  UIScrollView+Helper.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "UIScrollView+Helper.h"

#import "CTSpreeShopListViewController.h"

@implementation UIScrollView (Helper)

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if([NSStringFromClass(gestureRecognizer.delegate.class) isEqualToString:@"_UIQueuingScrollView"] && [otherGestureRecognizer.delegate isKindOfClass:CTSpreeShopListViewController.class]){
//        return YES;
//    }
//    return NO;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if([NSStringFromClass(gestureRecognizer.delegate.class) isEqualToString:@"_UIQueuingScrollView"] && [otherGestureRecognizer.delegate isKindOfClass:CTSpreeShopListViewController.class]){
        return YES;
    }
    return NO;
}


@end
