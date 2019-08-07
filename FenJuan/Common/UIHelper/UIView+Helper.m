//
//  UIView+Helper.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/9/21.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "UIView+Helper.h"


#import <objc/runtime.h>

static const int UIViewTapActionKey;

@interface UIViewHelper :NSObject

@property (nonatomic, copy) void(^block)(id target);

- (void)tapAction:(UITapGestureRecognizer *)tap;

@end

@implementation UIViewHelper

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if(self.block){
        self.block(tap.view);
    }
}

@end

@implementation UIView (Helper)

- (void)addActionWithBlock:(void(^)(id target))block{
    UIViewHelper *helper = [UIViewHelper new];
    helper.block = block;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:helper action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &UIViewTapActionKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
