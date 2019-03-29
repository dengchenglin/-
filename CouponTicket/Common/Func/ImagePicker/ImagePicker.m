//
//  ImagePicker.m
//  LightMaster
//
//  Created by dengchenglin on 2018/12/18.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "ImagePicker.h"

#import <MobileCoreServices/MobileCoreServices.h>

#import <objc/runtime.h>

static int ImagePickerhelperKey;

@interface ImagePickerhelper:NSObject<UIImagePickerControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, copy) void(^callback)(UIImage *image);

@end

@implementation ImagePickerhelper

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if(image && self.callback){
            self.callback(image);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
      objc_setAssociatedObject(picker, &ImagePickerhelperKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation ImagePicker

+ (void)showImagePickerWithViewController:(UIViewController *)viewController callback:(void(^)(UIImage *image))callback{

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = @[(NSString *)kUTTypeImage];
        [viewController presentViewController:picker animated:YES completion:nil];
        
        ImagePickerhelper *helper = [ImagePickerhelper new];
        helper.callback = callback;
        picker.delegate = helper;
        objc_setAssociatedObject(picker, &ImagePickerhelperKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
    }
 
}

@end
