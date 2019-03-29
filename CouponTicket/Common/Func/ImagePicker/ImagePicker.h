//
//  ImagePicker.h
//  LightMaster
//
//  Created by dengchenglin on 2018/12/18.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagePicker : NSObject

+ (void)showImagePickerWithViewController:(UIViewController *)viewController callback:(void(^)(UIImage *image))callback;

@end
