//
//  LMUpdateData.m
//  LightMaster
//
//  Created by Dankal on 2019/1/5.
//  Copyright © 2019 Qianmeng. All rights reserved.
//

#import "LMUpdateData.h"

#import <Qiniu/QiniuSDK.h>

#import <objc/runtime.h>

#import "KeychainTool.h"

#define LMQiniuTokenKey @"LMQiniuTokenKey"

#define LMQiniuTokenUrl @"http://api-lighting-dev.dankal.cn/v1/Communal/qiniu"

@interface LMUpdateHelper: NSObject

@property (nonatomic, copy)NSString *token;

@property (nonatomic, copy)NSData *data;

@property (nonatomic, copy)NSString *requestKey;

@property (nonatomic, copy)NSString *hashKey;

@property (nonatomic, strong)QNUploadManager *upManager;

@end

@implementation LMUpdateHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        _upManager = [[QNUploadManager alloc] init];
        
    }
    return self;
}

- (void)updateDataWithcallback:(void(^)(LMUpdateHelper *downloader))callback{
    if(!_data.length || !_requestKey.length || !_token.length)return;
    [_upManager putData:_data key:_requestKey token:_token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        self.hashKey = resp[@"hash"];
        if(callback){
            callback(self);
        }
    } option:nil];
}

@end

@implementation LMUpdateData

+ (void)load{
    //获取七牛token
    [self getToken:nil];
}



+ (NSString *)token{
    
    __block NSString *_token = objc_getAssociatedObject(self, LMQiniuTokenKey);
    if(_token)return _token;
    
     _token = [KeychainTool load:LMQiniuTokenKey];
    if(_token){
        objc_setAssociatedObject(self, LMQiniuTokenKey, _token, OBJC_ASSOCIATION_COPY_NONATOMIC);
        return _token;
    }
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    [self getToken:^(NSString *token) {
        _token = [token copy];
        dispatch_semaphore_signal(sem);
    }];
    dispatch_semaphore_wait(sem, 10);
    if(!_token){
        [MBProgressHUD showMBProgressHudWithTitle:@"token获取失败"];
    }
    return _token;
}

+ (void)getToken:(void(^)(NSString *token))callback{
    NSString *getTokenUrl = LMQiniuTokenUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:getTokenUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if(result){
                NSString *token = result[@"token"];
                if(callback){
                    callback(token);
                }
                
                [KeychainTool save:LMQiniuTokenKey data:token];
            }
        }
   
    }];
    [dataTask resume];
}


NSData *CompressedImage(UIImage *image){
    //尺寸压缩
    UIImage *compressedImage = [image imageByResizeWithMaxSize:CGSizeMake(1280, 1280)];
    //画质压缩
    CGFloat scale = 0.7f - ([UIImageJPEGRepresentation(compressedImage, 1) length] / 1000 - 2000) / 500 * 0.05f;
    if (scale <= 0) scale = 0.1;
    else if (scale > 1) scale = 1;
    return UIImageJPEGRepresentation(compressedImage, scale);
}

+ (void)updateImages:(NSArray <UIImage *>*)images callback:(void(^)(NSArray <NSString *> *hashKeys))callback{
    [self updateImages:images keys:nil callback:callback];
}

+ (void)updateImages:(NSArray <UIImage *>*)images keys:(NSArray <NSString *>*)keys callback:(void(^)(NSArray <NSString *> *hashKeys))callback{
    NSString *token = [self token];
    if(!token)return;
    if(!images.count)return;
    if(!keys){
        NSMutableArray *array = [NSMutableArray array];
        for(int i = 0;i < images.count;i ++){
           NSString * imgKey = [NSString stringWithFormat:@"limg%d%ld%d.jpeg",i,(long)[[NSDate date] timeIntervalSince1970],arc4random()];
            [array addObject:imgKey];
        }
        keys = [array copy];
    }
    
    NSMutableArray <LMUpdateHelper *>*downloaders = [NSMutableArray array];
    for(int i = 0;i < images.count;i ++){
        NSString *imgKey = [keys safe_objectAtIndex:i];
        NSData *imageData = CompressedImage(images[i]);
        LMUpdateHelper *updater = [[LMUpdateHelper alloc]init];
        updater.requestKey = imgKey;
        updater.data = imageData;
        updater.token = token;
        [downloaders addObject:updater];
    }
    
    UIViewController *viewController = [UIUtil getCurrentViewController];
    [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    
    dispatch_group_t group = dispatch_group_create();
    for(int i = 0; i< downloaders.count;i ++){
        
        LMUpdateHelper *updater = downloaders[i];
         dispatch_group_enter(group);
        [updater updateDataWithcallback:^(LMUpdateHelper *downloader) {
             dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:viewController.view animated:YES];
        
        NSArray <NSString *>*hashKeys = [downloaders map:^id(NSInteger index, LMUpdateHelper *element) {
            return element.requestKey;
        }];
        
        __block BOOL result = YES;
        [hashKeys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(!obj.length){
                [MBProgressHUD showMBProgressHudWithTitle:@"上传图片失败,请重新上传"];
                result = NO;
                *stop = YES;
            }
        }];
        if(callback && result){
            callback(hashKeys);
        }
    });
    
}


@end
