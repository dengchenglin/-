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

//生成二维码
+ (UIImage *)createQRCodeImageWithString:(nonnull NSString *)codeString andSize:(CGSize)size andBackColor:(nullable UIColor *)backColor andFrontColor:(nullable UIColor *)frontColor andCenterImage:(nullable UIImage *)centerImage;
@end
