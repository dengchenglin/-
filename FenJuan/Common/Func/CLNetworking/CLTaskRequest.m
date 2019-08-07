//
//  CLTaskRequest.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/10/23.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLTaskRequest.h"

@interface CLTaskRequest()

@property (nonatomic, copy) CLRequestDestinationBlock destinationBlock;

@property (nonatomic, copy) CLTaskCompletionHandler completionHandler;

@end


@implementation CLTaskRequest

- (CLTaskRequest *(^)(CLRequestDestinationBlock destinationBlock))setDestinationBlock{
    return ^CLTaskRequest *(CLRequestDestinationBlock destinationBlock){
        self.destinationBlock = destinationBlock;
        return self;
    };
}


- (CLTaskRequest *(^)(CLTaskCompletionHandler completionHandler))setCompletionHandler{
    return ^CLTaskRequest *(CLTaskCompletionHandler completionHandler){
        self.completionHandler = completionHandler;
        return self;
    };
}

@end

