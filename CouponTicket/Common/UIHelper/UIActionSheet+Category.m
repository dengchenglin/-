//
//  UIActionSheet+Category.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/9/20.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "UIActionSheet+Category.h"

#import <objc/runtime.h>

static const int UIActionSheetKey;

@interface UIActionSheet()<UIActionSheetDelegate>

@end

@implementation UIActionSheet (Category)

- (void)setBlock:(void(^)(NSUInteger buttonIndex))block{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIActionSheetKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    void(^block)(NSUInteger index) = objc_getAssociatedObject(self, &UIActionSheetKey);
    if(block){
        block(buttonIndex);
    }
}


@end
