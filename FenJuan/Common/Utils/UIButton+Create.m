//
//  UIButton+Create.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/29.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "UIButton+Create.h"
#import <objc/runtime.h>

static const int UIButtonFontKey;
static const int UIButtonBackgroundImageKey;
static const int UIButtonNormalTitleKey;
static const int UIButtonNormalTextColorKey;
static const int UIButtonSelectedTextColorKey;
static const int UIButtonSelectedTitleKey;
static const int UIButtonNormalImageKey;
static const int UIButtonSelectedImageKey;


UIButton *UIButtonCreateType(UIButtonType type){
    return [UIButton buttonWithType:type];
}

@implementation UIButton (Create)


- (void)setBackgroundImage:(UIImage *)backgroundImage{
      objc_setAssociatedObject(self, &UIButtonBackgroundImageKey, backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)backgroundImage{
    return objc_getAssociatedObject(self, &UIButtonBackgroundImageKey);
}

- (void)setFont:(UIFont *)font{
     objc_setAssociatedObject(self, &UIButtonFontKey, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)font{
     return objc_getAssociatedObject(self, &UIButtonFontKey);
}

- (void)setNormalTextColor:(UIColor *)normalTextColor{
    objc_setAssociatedObject(self, &UIButtonNormalTextColorKey, normalTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalTextColor{
    return objc_getAssociatedObject(self, &UIButtonNormalTextColorKey);
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor{
     objc_setAssociatedObject(self, &UIButtonSelectedTextColorKey, selectedTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)selectedTextColor{
    return objc_getAssociatedObject(self, &UIButtonSelectedTextColorKey);
}

- (void)setNormalTitle:(NSString *)normalTitle{
    objc_setAssociatedObject(self, &UIButtonNormalImageKey, normalTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)normalTitle{
    return objc_getAssociatedObject(self, &UIButtonNormalTitleKey);
}

- (void)setSelectedTitle:(NSString *)selectedTitle{
     objc_setAssociatedObject(self, &UIButtonSelectedTitleKey, selectedTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)selectedTitle{
    return objc_getAssociatedObject(self, &UIButtonSelectedTitleKey);
}

- (void)setNormalImage:(UIImage *)normalImage{
    objc_setAssociatedObject(self, &UIButtonNormalImageKey, normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalImage{
    return objc_getAssociatedObject(self, &UIButtonNormalImageKey);
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    objc_setAssociatedObject(self, &UIButtonSelectedImageKey, selectedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)selectedImage{
    return objc_getAssociatedObject(self, &UIButtonSelectedImageKey);
}



- (UIButton *(^)(CGRect frame))setFrame{
    return ^UIButton *(CGRect frame){
        self.frame = frame;
        return self;
    };
}

- (UIButton *(^)(UIFont *font))setFont{
    return ^UIButton *(UIFont *font){
        self.font = font;
        return self;
    };
}

- (UIButton *(^)(UIColor *backgroundColor))setBackgroundColor{
    return ^UIButton *(UIColor *backgroundColor){
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (UIButton *(^)(UIImage *backgroundImage))setBackgroundImage{
    return ^UIButton *(UIImage *backgroundImage){
        self.backgroundImage = backgroundImage;
        return self;
    };
}

- (UIButton *(^)(UIColor *normalTextColor))setNormalTextColor{
    return ^UIButton *(UIColor *normalTextColor){
        self.normalTextColor = normalTextColor;
        return self;
    };
}

- (UIButton *(^)(UIColor *selectedTextColor))setSelectedTextColor{
    return ^UIButton *(UIColor *selectedTextColor){
        self.selectedTextColor = selectedTextColor;
        return self;
    };
}

- (UIButton *(^)(NSString *normalTitle))setNormalTitle{
    return ^UIButton *(NSString *normalTitle){
        self.normalTitle = normalTitle;
        return self;
    };
}

- (UIButton *(^)(NSString *selectedTitle))setSelectedTitle{
    return ^UIButton *(NSString *selectedTitle){
        self.selectedTitle = selectedTitle;
        return self;
    };
}

- (UIButton *(^)(UIImage *normalImage))setNormalImage{
    return ^UIButton *(UIImage *normalImage){
        self.normalImage = normalImage;
        return self;
    };
}

- (UIButton *(^)(UIImage *selectedImage))setSelectedImage{
    return ^UIButton *(UIImage *selectedImage){
        self.selectedImage = selectedImage;
        return self;
    };
}

@end
