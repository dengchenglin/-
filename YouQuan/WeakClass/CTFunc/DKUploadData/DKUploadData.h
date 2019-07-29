//
//  DKUpdateData.h
//  LightMaster
//
//  Created by Dankal on 2019/1/5.
//  Copyright © 2019 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/PHAsset.h>

#import <Qiniu/QiniuSDK.h>


@interface DKUploadData : NSObject

//上传图片
+ (void)uploadImages:(NSArray <UIImage *>*)images callback:(void(^)(NSArray <NSString *> *imgUrls))callback;

+ (void)uploadImages:(NSArray <UIImage *>*)images showHud:(BOOL)showHud callback:(void(^)(NSArray <NSString *> *imgUrls))callback;

+ (void)uploadImages:(NSArray <UIImage *>*)images keys:(NSArray <NSString *>*)keys callback:(void(^)(NSArray <NSString *> *imgUrls))callback;

@end
