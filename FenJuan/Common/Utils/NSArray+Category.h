//
//  NSArray+Category.h
//  GeihuiDemo
//
//  Created by peikua on 17/3/17.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray <ObjectType>(Category)

- (ObjectType)safe_objectAtIndex:(NSUInteger)index;

- (NSString *)toString;

@end

@interface NSArray<ObjectType> (Map)

- (NSArray *)map:(id(^)(NSInteger index, ObjectType element))block;

@end
