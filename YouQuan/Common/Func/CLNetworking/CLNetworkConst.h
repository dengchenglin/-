//
//  CLNetworkConst.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/28.
//  Copyright © 2018年 Property. All rights reserved.
//

#ifndef CLNetworkConst_h
#define CLNetworkConst_h

// 网络请求类型
typedef NS_ENUM(NSUInteger, CLRequestTaskType) {
    Upload = 0,
    Download
};

// 网络请求类型
typedef NS_ENUM(NSUInteger, CLRequestMethodType) {
    GET = 0,
    POST,
    HEAD,
    PUT,
    PATCH ,
    DELETE
};

// 请求的序列化格式
typedef NS_ENUM(NSUInteger, CLRequestSerializerType) {
    RequestHTTP = 0,
    RequestJSON,
    RequestPlist
};

// 请求返回的序列化格式
typedef NS_ENUM(NSUInteger, CLResponseSerializerType) {
    ResponseHTTP = 0,
    ResponseJSON,
    ResponsePlist,
    ResponseXML
};


// 请求进度回调
typedef void(^CLProgressBlock)(NSProgress * __nullable progress);
// 请求结果回调
typedef void(^CLCallbackBlock)(id __nonnull request, id __nullable responseObject, NSError * __nullable error);
// 文件下载回调
typedef void(^CLTaskCompletionHandler)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error);

@protocol CLMultipartFormDataProtocol

- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                        error:(NSError * __nullable __autoreleasing *)error;
- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                        error:(NSError * __nullable __autoreleasing *)error;
- (void)appendPartWithInputStream:(nullable NSInputStream *)inputStream
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                           length:(int64_t)length
                         mimeType:(NSString *)mimeType;
- (void)appendPartWithFileData:(NSData *)data
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType;
- (void)appendPartWithFormData:(NSData *)data
                          name:(NSString *)name;
- (void)appendPartWithHeaders:(nullable NSDictionary *)headers
                         body:(NSData *)body;
- (void)throttleBandwidthWithPacketSize:(NSUInteger)numberOfBytes
                                  delay:(NSTimeInterval)delay;

@end

typedef void(^CLRequestConstructingBodyBlock)(id<CLMultipartFormDataProtocol> __nullable formData);

typedef NSURL *(^CLRequestDestinationBlock)(NSURL *targetPath,NSURLResponse *respone);

#endif /* CLNetworkConst_h */
