//
//  LMPhotoBrower.m
//  LightMaster
//
//  Created by dengchenglin on 2018/12/15.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "LMPhotoBrower.h"

#import "ZLPhotoActionSheet.h"

#import "ImagePicker.h"

#import "UIActionSheet+Category.h"

@implementation LMPhotoImageItem

@end

@implementation LMPhotoBrower

+ (void)showPhotoActionSheetWithMaxCount:(NSUInteger)maxCount callback:(void(^)(NSArray <LMPhotoImageItem *>*imageItems))callBack{
    if(maxCount <= 0)return;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"上传图片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    [sheet setBlock:^(NSUInteger buttonIndex) {
        if(buttonIndex == 0){
            [self showCamerasWithCallBack:^(NSArray<LMPhotoImageItem *> *imageItems) {
                if(callBack){
                    callBack(imageItems);
                }
            }];
        }
        if(buttonIndex == 1){
            [self showPhotoAlbumWithMaxCount:maxCount callBack:^(NSArray<LMPhotoImageItem *> *imageItems) {
                if(callBack){
                    callBack(imageItems);
                }
            }];
        }
    }];
}


+ (void)showCamerasWithCallBack:(void(^)(NSArray <LMPhotoImageItem *>*imageItems))callBack{
    UIViewController *vc = [UIUtil getCurrentViewController];
    if(vc){
        
        [ImagePicker showImagePickerWithViewController:vc callback:^(UIImage *image) {
            if(image){
                LMPhotoImageItem *item = [LMPhotoImageItem new];
                item.thumbImage = image;
                item.originalImage = image;
                if(callBack){
                    callBack(@[item]);
                }
            }
        }];
    }
   
}

+ (void)showPhotoAlbumWithMaxCount:(NSUInteger)maxCount callBack:(void(^)(NSArray <LMPhotoImageItem *>*imageItems))callBack{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    actionSheet.configuration.allowSelectVideo = NO;
    actionSheet.configuration.maxSelectCount = maxCount;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        NSMutableArray <LMPhotoImageItem *>*array = [NSMutableArray array];
        for(UIImage *image in images){
            LMPhotoImageItem *item = [LMPhotoImageItem new];
            item.thumbImage = image;
            item.originalImage = image;
            [array addObject:item];
        }
        if(callBack){
            callBack(array);
        }
    }];
    UIViewController *vc = [UIUtil getCurrentViewController];
    if(vc)[actionSheet showPhotoLibraryWithSender:vc];
}

@end
