//
//  CLTaskRequest.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/10/23.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLTaskRequest : CLRequest

@property (nonatomic, copy, readonly) CLRequestDestinationBlock destinationBlock;

@property (nonatomic, copy, readonly) CLTaskCompletionHandler completionHandler;


+ (instancetype)request;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (__kindof CLTaskRequest *(^)(NSString *customUrl))setCustomUrl;

- (__kindof CLTaskRequest *(^)(CLProgressBlock progressCallBack))setProgressCallBack;

- (CLTaskRequest *(^)(CLRequestDestinationBlock destinationBlock))setDestinationBlock;

- (CLTaskRequest *(^)(CLTaskCompletionHandler completionHandler))setCompletionHandler;

@end

NS_ASSUME_NONNULL_END
