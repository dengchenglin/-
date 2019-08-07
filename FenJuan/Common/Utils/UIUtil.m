
//
//  UIUtil.m
//  YMKMain
//
//  Created by dengchenglin on 2018/7/9.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "UIUtil.h"

@implementation UIUtil

+ (UIScrollView *)getSuperScrollViewWithView:(UIView *)view{
    if([[view nextResponder] isKindOfClass:[UIScrollView class]] || [view nextResponder] == nil){
        return (UIScrollView *)[view nextResponder];
    }
    return [UIUtil getSuperScrollViewWithView:view.superview];
}

+ (UIViewController *)getSuperViewControllerWithView:(UIView *)view{
    if([[view nextResponder] isKindOfClass:[UIViewController class]] || [view nextResponder] == nil){
        return (UIViewController *)[view nextResponder];
    }
    return [UIUtil getSuperViewControllerWithView:view.superview];
}

+ (UIViewController *)getCurrentViewController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        //多层present
        while (appRootVC.presentedViewController) {
            appRootVC = appRootVC.presentedViewController;
            if (appRootVC) {
                nextResponder = appRootVC;
            }else{
                break;
            }
        }
        //        nextResponder = appRootVC.presentedViewController;
    }else if(window.subviews.count > 0){
        
        //        NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    if(![nextResponder isKindOfClass:UIViewController.class]){
        return nil;
    }
    else{
        result = [self getTopWithViewController:nextResponder];
    }
    return result;
}

+ (UIViewController *)getTopWithViewController:(UIViewController *)viewController{
    if([viewController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tab = (UITabBarController *)viewController;
        if(tab.viewControllers){
            UIViewController *vc = [self getTopWithViewController:tab.viewControllers[tab.selectedIndex]];
            return vc;
        }
    }
    else if([viewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)viewController;
        if(nav.viewControllers){
            UIViewController *vc = [self getTopWithViewController:nav.viewControllers.lastObject];
            return vc;
        }
    }
    return viewController;
}

//生成二维码
+ (UIImage *)createQRCodeImageWithString:(nonnull NSString *)codeString andSize:(CGSize)size andBackColor:(nullable UIColor *)backColor andFrontColor:(nullable UIColor *)frontColor andCenterImage:(nullable UIImage *)centerImage{
    
    NSData *stringData = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //    NSLog(@"%@",qrFilter.inputKeys);
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    //放大并绘制二维码 (上面生成的二维码很小，需要放大)
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    //绘制颜色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",[CIImage imageWithCGImage:codeImage.CGImage],
                             @"inputColor0",[CIColor colorWithCGColor:frontColor == nil ? [UIColor clearColor].CGColor: frontColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor: backColor == nil ? [UIColor blackColor].CGColor : backColor.CGColor],
                             nil];
    
    UIImage * colorCodeImage = [UIImage imageWithCIImage:colorFilter.outputImage];
    
    //中心添加图片
    if (centerImage != nil) {
        
        UIGraphicsBeginImageContext(colorCodeImage.size);
        
        [colorCodeImage drawInRect:CGRectMake(0, 0, colorCodeImage.size.width, colorCodeImage.size.height)];
        
        UIImage *image = centerImage;
        
        CGFloat imageW = 50;
        CGFloat imageX = (colorCodeImage.size.width - imageW) * 0.5;
        CGFloat imgaeY = (colorCodeImage.size.height - imageW) * 0.5;
        
        [image drawInRect:CGRectMake(imageX, imgaeY, imageW, imageW)];
        
        UIImage *centerImageCode = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return centerImageCode;
    }
    return colorCodeImage;
}



+ (UIImage *)getLaunchImage{
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *launchImage = nil;
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        // 横屏改成 @"Landscape"
        if (CGSizeEqualToSize(imageSize, viewSize) && [@"Portrait" isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImage];
}

@end
