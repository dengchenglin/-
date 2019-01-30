//
//  LMPhotoBrower.h
//  LightMaster
//
//  Created by dengchenglin on 2018/12/15.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMPhotoImageItem :NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) UIImage *originalImage;//原图

@property (nonatomic, copy) UIImage *thumbImage;//缩略图

@end

@interface LMPhotoBrower : NSObject

+ (void)showPhotoActionSheetWithMaxCount:(NSUInteger)maxCount callback:(void(^)(NSArray <LMPhotoImageItem *>*imageItems))callBack;

+ (void)showCamerasWithCallBack:(void(^)(NSArray <LMPhotoImageItem *>*imageItems))callBack;

+ (void)showPhotoAlbumWithMaxCount:(NSUInteger)maxCount callBack:(void(^)(NSArray <LMPhotoImageItem *>*imageItems))callBack;

@end
