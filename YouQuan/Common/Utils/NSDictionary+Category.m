//
//  NSDictionary+Category.m
//  BibleReader
//
//  Created by dengchenglin on 2018/8/16.
//  Copyright © 2018年 Dengchenglin. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

- (NSString *)toString

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }

    

    return jsonString;
    
}

@end
