//
//  CTNetworkEngine.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

#import "CTAppManager.h"

#import <CommonCrypto/CommonHMAC.h>

#import <objc/runtime.h>

#define CT_APP_VERSION                      [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define CT_SIGN_MODEL                       [UIDevice currentDevice].model
#define CT_SIGN_SYSTEM_VERSION              [UIDevice currentDevice].systemVersion
#define CT_SIGN_DEVICE_ID                   [[UIDevice currentDevice].identifierForVendor UUIDString]

static const int request_vc_key;

@implementation CTNetworkEngine

+ (instancetype)sharedInstance{
    static CTNetworkEngine *networkEngine = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        networkEngine = [[CTNetworkEngine alloc]init];
    });
    return networkEngine;
}


+ (NSString *)baseUrl{
    return [CLNetworkManager shareInstance].config.request.baseUrl;
}

+ (void)initialize{
    [CLNetworkManager setupConfig:^(CLNetworkConfig *config) {
        config.request.baseUrl = CT_API_BASE_URL;
        config.responseSerializerType = ResponseJSON;
        config.request.requestTimeoutInterval = 15;
    }];
}



- (CLRequest *)getWithPath:(NSString *)path params:(NSDictionary *)params callback:(CTResponseBlock)callback{
    return [self requestWithMethod:GET path:path params:params images:nil showHud:YES callback:callback];
}

- (CLRequest *)getWithPath:(NSString *)path params:(NSDictionary *)params showHud:(BOOL)showHud callback:(CTResponseBlock)callback{
    return [self requestWithMethod:GET path:path params:params images:nil showHud:showHud callback:callback];
}

- (CLRequest *)postWithPath:(NSString *)path params:(NSDictionary *)params callback:(CTResponseBlock)callback{
    return [self postWithPath:path params:params showHud:YES callback:callback];
}


- (CLRequest *)postWithPath:(NSString *)path params:(NSDictionary *)params showHud:(BOOL)showHud callback:(CTResponseBlock)callback{
    return [self postWithPath:path params:params images:nil showHud:showHud callback:callback];
}
- (CLRequest *)postWithPath:(NSString *)path params:(NSDictionary *)params showHud:(BOOL)showHud showErrorHud:(BOOL)showErrorHud callback:(CTResponseBlock)callback{
    return [self requestWithMethod:POST path:path params:params images:nil showHud:showHud showErrorHud:showErrorHud callback:callback];
}


- (CLRequest *)postWithPath:(NSString *)path params:(NSDictionary *)params images:(NSArray <UIImage *>*)images showHud:(BOOL)showHud callback:(CTResponseBlock)callback{
    return [self requestWithMethod:POST path:path params:params images:images showHud:showHud callback:callback];
}

- (CLRequest *)requestWithMethod:(CLRequestMethodType)methodType path:(NSString *)path params:(NSDictionary *)params images:(NSArray <UIImage *>*)images showHud:(BOOL)showHud callback:(CTResponseBlock)callback{
    return [self requestWithMethod:methodType path:path params:params images:images showHud:showHud showErrorHud:YES callback:callback];
}

- (CLRequest *)requestWithMethod:(CLRequestMethodType)methodType path:(NSString *)path params:(NSDictionary *)params images:(NSArray <UIImage *>*)images showHud:(BOOL)showHud showErrorHud:(BOOL)showErrorHud callback:(CTResponseBlock)callback{
    NSDictionary *refactorParams = [self refactorParams:params];
    NSMutableString *urlString = [[NSMutableString alloc]initWithFormat:@"%@/%@",[CLNetworkManager shareInstance].config.request.baseUrl,path];
    [urlString appendString:@"?"];
    for(NSString *key in refactorParams.allKeys){
        [urlString appendFormat:@"%@=%@&",key,refactorParams[key]];
    }
    DBLog(@"url is --%@\n\n" ,urlString);
    DBLog(@"url is --%@\n\n params is --%@\n\n" ,[NSString stringWithFormat:@"%@/%@",[CLNetworkManager shareInstance].config.request.baseUrl,path],refactorParams);

    CLURLRequest *request = [CLURLRequest request].setMethod(methodType).setConstructingBodyBlock(images.count?^(id<CLMultipartFormDataProtocol> __nullable formData){
        for(int i = 0;i < images.count;i ++){
            [formData appendPartWithFileData:UIImageJPEGRepresentation(images[i], 0.5) name:[NSString stringWithFormat:@"img%d",i] fileName:@"image.png" mimeType:@"image/png"];
        }
    }:nil).setPath(path).setParams(refactorParams).setCallBack(^(CLURLRequest * __nonnull request, id __nullable responseObject, NSError * __nullable error){
        DBLog(@"responseObject is --%@\n\n",responseObject);
        
        UIViewController *currentVC = objc_getAssociatedObject(request, &request_vc_key);
        if(currentVC){
            [MBProgressHUD hideHUDForView:currentVC.view animated:YES];
            
        }
        if(error){
            if(callback){
                callback(nil,request,CTNetErrorNet);
            }
        }
        else{
            NSInteger status = [responseObject[@"status"] integerValue];
            if(status == 200){
                if(callback){
                    callback(responseObject[@"data"],request,CTNetErrorNone);
                }
            }
            else{
                NSString *info = responseObject[@"info"];
                if(info.length){
                    [MBProgressHUD showMBProgressHudWithTitle:info];
                }
                if(callback){
                    callback(responseObject,request,CTNetErrorStatus);
                }
            }
        }
    });
    [request start];
    
    UIViewController *currentVC = [UIUtil getCurrentViewController];
    if(showHud && currentVC){
        [MBProgressHUD showMBProgressHudOnView:currentVC.view];
    }
    if(currentVC){
        objc_setAssociatedObject(request, &request_vc_key, currentVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return request;
}




- (NSDictionary *)refactorParams:(NSDictionary *)params{
    NSMutableDictionary *refactorParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [refactorParams setValuesForKeysWithDictionary:[self getPublicParam]];
    
    return [refactorParams copy];
}



- (NSDictionary *)getPublicParam
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[CTAppManager sharedInstance].token forKey:@"token"];
    [dic setValue:@"ios" forKey:@"app_type"];
    [dic setValue:CT_APP_VERSION forKey:@"app_version"];
    [dic setValue:CT_SIGN_SYSTEM_VERSION forKey:@"system_version"];
    [dic setValue:CT_SIGN_DEVICE_ID forKey:@"device_id"];
    
//#ifdef DEBUG
//    [dic setValue:@"1" forKey:@"app_test"];
//#endif
    return dic;
}

@end
