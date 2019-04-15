//
//  UIButton+Create.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/29.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <UIKit/UIKit.h>

 UIButton *UIButtonCreateType(UIButtonType type);

@interface UIButton (Create)

@property (nonatomic, strong, nullable) UIFont *font;

@property (nonatomic, strong, nullable) UIImage *backgroundImage;

@property (nonatomic, strong, nullable) NSString *normalTitle;

@property (nonatomic, strong, nullable) NSString *selectedTitle;

@property (nonatomic, strong, nullable) UIColor *normalTextColor;

@property (nonatomic, strong, nullable) UIColor *selectedTextColor;

@property (nonatomic, strong, nullable) UIImage *normalImage;

@property (nonatomic, strong, nullable) UIImage *selectedImage;


- (UIButton *(^)(CGRect frame))setFrame;

- (UIButton *(^)(UIFont *font))setFont;

- (UIButton *(^)(UIColor *backgroundColor))setBackgroundColor;

- (UIButton *(^)(UIImage *backgroundImage))setBackgroundImage;

- (UIButton *(^)(UIColor *normalTextColor))setNormalTextColor;

- (UIButton *(^)(UIColor *selectedTextColor))setSelectedTextColor;

- (UIButton *(^)(NSString *normalTitle))setNormalTitle;

- (UIButton *(^)(NSString *selectedTitle))setSelectedTitle;

- (UIButton *(^)(UIImage *normalImage))setNormalImage;

- (UIButton *(^)(UIImage *selectedImage))setSelectedImage;

@end
