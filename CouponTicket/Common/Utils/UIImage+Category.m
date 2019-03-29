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
    if(error){
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"保存失败！\n请前往“设置-隐私-照片”中检查是否开启访问权限" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        [alt show];
        [alt.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
            if(x.integerValue == 1){
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }];
        
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

