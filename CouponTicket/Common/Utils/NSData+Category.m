//
//  NSData+Category.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/11/7.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "NSData+Category.h"

@implementation NSData (Category)
- (id)jsonValueDecoded {
    if(!self)return nil;
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}
@end
