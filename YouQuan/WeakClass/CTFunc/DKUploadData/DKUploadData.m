//
//  DKUpdateData.m
//  LightMaster
//
//  Created by Dankal on 2019/1/5.
//  Copyright © 2019 Qianmeng. All rights reserved.
//

#import "DKUploadData.h"

#import <objc/runtime.h>

#import "KeychainTool.h"


#define DKQiniuTokenKey @"DKQiniuTokenKey"
#define DKQiniuDomainKey @"DKQiniuDomainKey"

#define DKQiniuTokenUrl  [CT_API_BASE_URL stringByAppendingPathComponent:@"api/common/getQiniuToken"]


@interface DKUploadHelper: NSObject

@property (nonatomic, copy)NSString *token;

@property (nonatomic, copy)NSData *data;

@property (nonatomic, copy)NSString *requestKey;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy)NSString *hashKey;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, strong)QNUploadManager *upManager;

@end

@implementation DKUploadHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        _upManager = [[QNUploadManager alloc] init];
       
    }
    return self;
}

- (void)updateDataWithcallback:(void(^)(DKUploadHelper *downloader))callback{
    if(!_data.length || !_requestKey.length || !_token.length)return;
    [_upManager putData:_data key:_requestKey token:_token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        self.hashKey = resp[@"hash"];
        if(callback){
            callback(self);
        }
    } option:nil];
}

@end

@implementation DKUploadData

+ (void)load{
    //获取七牛token
    [self getToken:nil];
}

+ (NSString *)token{
   
    __block NSString *_token = objc_getAssociatedObject(self, DKQiniuTokenKey);
    if(_token)return _token;
  
    _token = [[NSUserDefaults standardUserDefaults]objectForKey:DKQiniuTokenKey];
    if(_token){
        objc_setAssociatedObject(self, DKQiniuTokenKey, _token, OBJC_ASSOCIATION_COPY_NONATOMIC);
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

+ (NSString *)domain{
    __block NSString *_domain = objc_getAssociatedObject(self, DKQiniuDomainKey);
    if(_domain)return _domain;
    _domain = [[NSUserDefaults standardUserDefaults]objectForKey:DKQiniuDomainKey];
    if(_domain){
        objc_setAssociatedObject(self, DKQiniuDomainKey, _domain, OBJC_ASSOCIATION_COPY_NONATOMIC);
        return _domain;
    }
    return _domain;
}

+ (void)getToken:(void(^)(NSString *token))callback{
    NSString *getTokenUrl = DKQiniuTokenUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:getTokenUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if(result){
                NSString *token = result[@"data"][@"token"];
                NSString *domain = result[@"data"][@"qiniu_domain"];
                if(callback){
                    callback(token);
                }
                [[NSUserDefaults standardUserDefaults]setValue:token forKey:DKQiniuTokenKey];
                [[NSUserDefaults standardUserDefaults]setValue:domain forKey:DKQiniuDomainKey];
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



+ (void)uploadImages:(NSArray <UIImage *>*)images callback:(void(^)(NSArray <NSString *> *hashKeys))callback{
    [self uploadImages:images keys:nil callback:callback];
}

+ (void)uploadImages:(NSArray <UIImage *>*)images keys:(NSArray <NSString *>*)keys callback:(void(^)(NSArray <NSString *> *imgUrls))callback{
    [self uploadImages:images keys:keys showHud:YES callback:callback];
}

+ (void)uploadImages:(NSArray <UIImage *>*)images showHud:(BOOL)showHud callback:(void(^)(NSArray <NSString *> *imgUrls))callback{
    [self uploadImages:images keys:nil showHud:showHud callback:callback];
}

+ (void)uploadImages:(NSArray <UIImage *>*)images keys:(NSArray <NSString *>*)keys showHud:(BOOL)showHud callback:(void(^)(NSArray <NSString *> *imgUrls))callback{
    NSString *token = [self token];
    if(!token)return;
    NSString *domain = [self domain];
    if(!images.count)return;
    if(!keys){
        NSMutableArray *array = [NSMutableArray array];
        for(int i = 0;i < images.count;i ++){
           NSString * imgKey = [NSString stringWithFormat:@"dk_img%d%ld%d.png",i,(long)[[NSDate date] timeIntervalSince1970],arc4random()];
            [array addObject:imgKey];
        }
        keys = [array copy];
    }
    
    NSMutableArray <DKUploadHelper *>*downloaders = [NSMutableArray array];
    for(int i = 0;i < images.count;i ++){
        NSString *imgKey = [keys safe_objectAtIndex:i];
        NSData *imageData = CompressedImage(images[i]);
        DKUploadHelper *updater = [[DKUploadHelper alloc]init];
        updater.requestKey = imgKey;
        updater.data = imageData;
        updater.token = token;
        updater.imgUrl = [domain stringByAppendingFormat:@"/%@",imgKey];
        [downloaders addObject:updater];
    }
    
    UIViewController *cuttentViewController;
    if(showHud){
        cuttentViewController = [UIUtil getCurrentViewController];
        [MBProgressHUD showHUDAddedTo:cuttentViewController.view animated:YES];
    }
    dispatch_group_t group = dispatch_group_create();
    for(int i = 0; i< downloaders.count;i ++){
        
        DKUploadHelper *updater = downloaders[i];
         dispatch_group_enter(group);
        [updater updateDataWithcallback:^(DKUploadHelper *downloader) {
             dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if(cuttentViewController){
             [MBProgressHUD hideHUDForView:cuttentViewController.view animated:YES];
        }
       
        NSArray <NSString *>*imgUrls = [downloaders map:^id(NSInteger index, DKUploadHelper *element) {
            return element.imgUrl;
        }];
        __block BOOL result = YES;
        [imgUrls enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(!obj.length){
                [MBProgressHUD showMBProgressHudWithTitle:@"上传图片失败,请重新上传"];
                result = NO;
                *stop = YES;
            }
        }];
        if(callback && result){
            callback(imgUrls);
        }
    });
}


@end
