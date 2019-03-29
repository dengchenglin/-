//
//  UIImageView+Helper.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/10/19.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "UIImageView+Helper.h"
#import <objc/runtime.h>
#import "UIImageView+WebCache.h"

static const int UIImageViewTapActionKey;

@interface UIImageViewHelper :NSObject

@property (nonatomic, copy) void(^block)(id target);

- (void)tapAction:(UITapGestureRecognizer *)tap;

@end

@implementation UIImageViewHelper

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if(self.block){
        self.block(tap.view);
    }
}

@end
@implementation UIImageView (Helper)
- (void)addActionWithBlock:(void(^)(id target))block{
    self.userInteractionEnabled = YES;
    UIImageViewHelper *helper = [UIImageViewHelper new];
    helper.block = block;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:helper action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &UIImageViewTapActionKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cl_setImageWithImg:(id)img{
    if([img isKindOfClass:[NSString class]]){
        if([img hasPrefix:@"http"]){
            [self sd_setImageWithURL:[NSURL URLWithString:img]];
        }
        else{
            [self sd_setImageWithURL:[NSURL URLWithString:img]];
        }
    }
    else if([img isKindOfClass:[UIImage class]]){
        self.image = img;
    }
}

@end
