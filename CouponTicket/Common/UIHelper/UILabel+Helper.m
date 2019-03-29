//
//  UILabel+Helper.m
//  
//
//  Created by dengchenglin on 2018/9/20.
//

#import "UILabel+Helper.h"

#import <objc/runtime.h>

static const int UIlabelTapActionKey;

@interface UIlabelHelper :NSObject

@property (nonatomic, copy) void(^block)(id target);

- (void)tapAction:(UITapGestureRecognizer *)tap;

@end

@implementation UIlabelHelper

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if(self.block){
        self.block(tap.view);
    }
}

@end

@implementation UILabel (Helper)

- (void)addActionWithBlock:(void(^)(id target))block{
    UIlabelHelper *helper = [UIlabelHelper new];
    helper.block = block;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:helper action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &UIlabelTapActionKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
