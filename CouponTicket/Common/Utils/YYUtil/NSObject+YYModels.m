//
//  NSObject+YYModels.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/27.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "NSObject+YYModels.h"

#import "NSObject+YYModel.h"

@implementation NSObject (YYModels)

+ (nullable NSArray *)yy_modelsWithDatas:(NSArray *)datas{
    NSMutableArray *array = [NSMutableArray array];
    for(NSDictionary *data in datas){
        [array addObject:[self yy_modelWithJSON:data]];
    }
    return [array copy];
}

@end
