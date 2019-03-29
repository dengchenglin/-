//
//  UIImage+Category.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/29.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
//图片压缩
- (UIImage *)imageByResizeWithMaxSize:(CGSize)size;
//保存到相册
- (void)saveToPhotosWithCompleted:(void(^)(BOOL success))completed;
@end

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)imageWithColor:(UIColor *)color;


@end
