//
//  NSArray+Log.m
//  GeihuiWang
//
//  Created by dengchenglin on 2018/4/14.
//  Copyright © 2018年 qianmeng. All rights reserved.
//

#import "NSArray+Log.h"

#import "NSString+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale{
    return self.description.unicodeString;
}
- (NSString *)debugDescription{
    return self.description.unicodeString;
}

@end
