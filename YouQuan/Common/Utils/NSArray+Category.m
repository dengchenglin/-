//
//  NSArray+Category.m
//  GeihuiDemo
//
//  Created by peikua on 17/3/17.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)

- (id)safe_objectAtIndex:(NSUInteger)index{
    if((NSInteger)index > (NSInteger)self.count - 1){
        return nil;
    }
    return [self objectAtIndex:index];
}
- (NSString *)toString{
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

@implementation NSArray (Map)

- (NSArray *)map:(id(^)(NSInteger index, id element))block{
    NSMutableArray *array = [NSMutableArray array];
    for(NSInteger index = 0;index < self.count;index ++){
        [array addObject:block(index,self[index])];
    }
    return array.copy;
}

@end
