//
//  RegalurUntil.m
//  正则表达式
//
//  Created by chenguangjiang on 15/11/16.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "RegalurUtil.h"

@implementation RegalurUtil
+ (BOOL)isMatchString:(NSString *)string withRule:(NSString *)rule{
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"self matches %@",rule];
    BOOL result = [predicate1 evaluateWithObject:string];
    return result;
}
+ (NSArray *)resultsWithMatchString:(NSString *)string withRule:(NSString *)rule{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:rule options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    NSMutableArray *array = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [string substringWithRange:match.range];
        [array addObject:tagValue];
    }
    return array;
}

+(NSString *)jiexi:(NSString *)CS webaddress:(NSString *)webaddress
{
    if(!webaddress)return nil;
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",CS];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:webaddress options:0 range:NSMakeRange(0, [webaddress length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];
        return tagValue;
    }
    return @"";
}
@end
