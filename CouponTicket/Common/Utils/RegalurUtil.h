//
//  RegalurUntil.h
//  正则表达式
//
//  Created by chenguangjiang on 15/11/16.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegalurUtil : NSObject

+(BOOL)isMatchString:(NSString *)string withRule:(NSString *)rule;

+(NSArray *)resultsWithMatchString:(NSString *)string withRule:(NSString *)rule;
@end
