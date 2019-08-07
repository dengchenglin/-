//
//  HLNetworkEngine.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/28.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "CLNetworkEngine.h"
#import "CLURLRequest.h"
#import "CLTaskRequest.h"
#import "CLNetworkConfig.h"
#import "CLNetworkDefines.h"
#import <AFNetworking/AFNetworking.h>

@interface CLNetworkEngine ()

@property (nonatomic, strong) NSMutableDictionary *sessionManagerCache;

@property (nonatomic, strong) NSMutableDictionary *sessionTaskCache;

@end

@implementation CLNetworkEngine{
    NSLock *_lock;
}

+ (CLNetworkEngine *)sharedEngine {
    static CLNetworkEngine *networkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkEngine = [[self alloc] init];
    });
    return networkEngine;
}

- (NSMutableDictionary<NSString *,AFURLSessionManager *> *)sessionManagerCache{
    if(!_sessionManagerCache){
        _sessionManagerCache = [NSMutableDictionary dictionary];
    }
    return _sessionManagerCache;
}

- (NSMutableDictionary *)sessionTaskCache{
    if(!_sessionTaskCache){
        _sessionTaskCache = [NSMutableDictionary dictionary];
    }
    return _sessionTaskCache;
}


- (void)sendRequest:(__kindof CLRequest * _Nonnull)request
          config:(CLNetworkConfig * _Nonnull)config
       progressCallBack:(CLProgressBlock _Nullable)progressCallBack
           callBack:(CLCallbackBlock _Nullable)callBack{
    if(!request)return;
    if(!config)return;
    
  
    //url
    
    NSString *requestUrl = request.customUrl;
    NSString *baseUrl = request.customUrl;
    
    if(!request.customUrl){
        baseUrl = request.baseUrl ?: config.request.baseUrl;
        NSAssert(baseUrl != nil,
                 @"request baseURL 和 config.baseurl 两者必须有一个有值");
        NSURL *url = [NSURL URLWithString:baseUrl];
        if(!url.host){
            NSLog(@"requrstUrl 无效");
        }
        
        requestUrl = baseUrl;
        
        //path
        if(request.path){
            requestUrl = [requestUrl stringByAppendingPathComponent:request.path];
        }
    }
  
   

    //params
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(config.globalParams && request.useGlobalParams){
        [params setDictionary:config.globalParams];
    }
    if(request.params){
        [params setDictionary:request.params];
    }
    
  
  
    
    //callback
   
    void (^progressBlock)(NSProgress *progress)
    = ^(NSProgress *progress) {
        if (progress.totalUnitCount <= 0) return;
        dispatch_async_main(^{
            if (progressCallBack) {
                progressCallBack(progress);
            }
        });
    };
     __weak typeof(self) weakSelf = self;
    void (^successBlock)(NSURLSessionDataTask *task, id responseObject)
    = ^(NSURLSessionDataTask * task, id resultObject) {
        
        if (callBack) {
            request.task = task;
            callBack(request, resultObject, nil);
        }
        [weakSelf removeCachesRequest:request];
    };
    
    void (^failureBlock)(NSURLSessionDataTask * task, NSError * error)
    = ^(NSURLSessionDataTask * task, NSError * error) {
        
        if (callBack) {
            request.task = task;
            callBack(request, nil, error);
        }
        [weakSelf removeCachesRequest:request];
    };
    
     //常规请求
    if([request isKindOfClass:[CLURLRequest class]]){
        CLURLRequest *urlRequest = (CLURLRequest *)request;
        
        void (^formDataBlock)(id <AFMultipartFormData> formData) = nil;
        if(urlRequest.constructingBodyBlock){
           
           formDataBlock = ^(id <AFMultipartFormData> formData) {
         urlRequest.constructingBodyBlock((id<CLMultipartFormDataProtocol>)formData);
            };
        }
        
        AFHTTPSessionManager *sessionManager = [self createSessionManager:request config:config baseURLString:baseUrl];
        NSURLSessionDataTask *dataTask = [self sendRequestWithSession:sessionManager requestUrl:requestUrl method:urlRequest.requestMethod  parmas:params formDataBlock:formDataBlock progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
        [self.sessionTaskCache setValue:dataTask forKey:request.identifier];
    }
    //文件下载
    if([request isKindOfClass:[CLTaskRequest class]]){
        CLTaskRequest *taskRequest = (CLTaskRequest *)request;
        NSURL *(^desinationBlock)(NSURL *targetPath, NSURLResponse *response) = nil;
        if(taskRequest.destinationBlock){
            desinationBlock = taskRequest.destinationBlock;
        }

        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]] progress:progressBlock destination:desinationBlock completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {

            if(taskRequest.completionHandler){
                taskRequest.completionHandler(response, filePath, error);
            }
        }];
        [downloadTask resume];
        [_lock lock];
        [self.sessionTaskCache setValue:downloadTask forKey:request.identifier];
        [_lock unlock];
    }
}



- (NSURLSessionDataTask *)sendRequestWithSession:(AFHTTPSessionManager *)session requestUrl:(NSString *)requestUrl method:(CLRequestMethodType)method parmas:(NSDictionary *)params formDataBlock:formDataBlock progressBlock:(void (^)(NSProgress *progress))progressBlock successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock failureBlock:(void (^)(NSURLSessionDataTask * task, NSError * error))failureBlock{
 
    NSURLSessionDataTask *dataTask;

    switch (method) {
        case GET:
        {
            dataTask =
            [session GET:requestUrl
              parameters:params
                progress:progressBlock
                 success:successBlock
                 failure:failureBlock];
        }
            break;
        case POST:
        {
            if(formDataBlock){
                dataTask =
                [session POST:requestUrl parameters:params constructingBodyWithBlock:formDataBlock progress:progressBlock success:successBlock failure:failureBlock];
            }
            else{
                dataTask =
                [session POST:requestUrl parameters:params  progress:progressBlock success:successBlock failure:failureBlock];
            }
           
        }
            break;
        case DELETE:
        {
            dataTask =
            [session DELETE:requestUrl parameters:params success:successBlock failure:failureBlock];
           break;
        }
        case PUT:
        {
            dataTask =
            [session PUT:requestUrl parameters:params success:successBlock failure:failureBlock];
            break;
        }
        default:
            break;
    }
    return dataTask;
}

- (AFHTTPSessionManager *)createSessionManager:(CLRequest *)request
                                        config:(CLNetworkConfig *)config
                                 baseURLString:(NSString *)baseUrlStr

{
    AFHTTPSessionManager *sessionManager = [self.sessionManagerCache objectForKey:baseUrlStr];
    if(!sessionManager){
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.HTTPMaximumConnectionsPerHost = config.request.httpMaximumConnectionsPerHost;
        sessionConfig.requestCachePolicy = request.cachePolicy ?: config.cachePolicy;
        sessionConfig.timeoutIntervalForRequest = request.timeoutInterval ?: config.request.requestTimeoutInterval;
        sessionConfig.URLCache = config.URLCache;
 
        
        sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfig];
        [self.sessionManagerCache setObject:sessionManager forKey:baseUrlStr];
    }
    AFHTTPRequestSerializer *requestSerializer;
    switch (config.requestSerializerType) {
        case RequestHTTP:
            requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case RequestJSON:
            requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case RequestPlist:
            requestSerializer = [AFPropertyListRequestSerializer serializer];
            break;
        default:
            requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    sessionManager.requestSerializer = requestSerializer;
    for(NSString *key in request.httpHeaderFields.allKeys){
        [sessionManager.requestSerializer setValue:request.httpHeaderFields[key] forHTTPHeaderField:key];
    }
    
    AFHTTPResponseSerializer *responseSerializer;
    switch (config.responseSerializerType) {
        case ResponseHTTP:
            responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case ResponseJSON:
            responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ResponsePlist:
            responseSerializer = [AFPropertyListResponseSerializer serializer];
            break;
        case ResponseXML:
            responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
    }
    responseSerializer.acceptableContentTypes = config.accpetContentTypes;
    sessionManager.responseSerializer = responseSerializer;

    return sessionManager;
}


- (void)cancelRequest:(CLRequest *)request{
    if(!request)return;
    NSURLSessionTask *task = self.sessionTaskCache[request.identifier];
    if(task)[task cancel];
    
}

- (void)resumeRequest:(CLRequest *)request{
    if(!request)return;
    NSURLSessionTask *task = self.sessionTaskCache[request.identifier];
    if(task)[task resume];
}

- (void)pauseRequest:(CLRequest *)request{
    if(!request)return;
    NSURLSessionTask *task = self.sessionTaskCache[request.identifier];
    if(task)[task suspend];
}

- (void)removeCachesRequest:(CLRequest *)request{
    [_lock lock];
    if([self.sessionTaskCache.allKeys containsObject:request.identifier]){
        [self.sessionTaskCache removeObjectForKey:request.identifier];
    }
    [_lock unlock];
}

@end
