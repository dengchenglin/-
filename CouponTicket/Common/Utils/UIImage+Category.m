//
//  UIImage+Category.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/29.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

- (UIImage *)imageByResizeWithMaxSize:(CGSize)size{
    CGSize resize = self.size;
    if(resize.width > size.width){
        resize = CGSizeMake(size.width, size.width/resize.width * resize.height);
    }
    if(resize.height > size.height){
        resize = CGSizeMake(size.height/resize.height * resize.width, size.height);
    }
    if (resize.width <= 0 || resize.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(resize, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, resize.width, resize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)saveToPhotosWithCompleted:(void(^)(BOOL success))completed{
    void *contextInfo = (__bridge void *)completed;
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), contextInfo);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    void(^completed)(BOOL success) = (__bridge void (^)(BOOL))(contextInfo);
   if(completed)
   {
       completed(error?NO:YES);
   }
}
@end
@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}



- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

