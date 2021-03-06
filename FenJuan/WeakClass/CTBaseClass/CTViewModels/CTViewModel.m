//
//  CTViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

@implementation CTViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    CTViewModel *viewModel = [super allocWithZone:zone];
    [viewModel initialize];
    return viewModel;
}

- (void)initialize{}

+ (id)bindModel:(id)model{
    
    return nil;
}

+ (NSArray *)bindModels:(NSArray *)models{
    NSMutableArray *array = [NSMutableArray array];
    for(id model in models){
        id viewModel = [self bindModel:model];
        if(viewModel){
            [array addObject:viewModel];
        }
    }
    return array;
}
@end
