
//
//  CTEarnRankIndexViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTEarnRankIndexViewModel.h"

#import "CTEarnRankModel.h"

@implementation CTEarnRankIndexViewModel

+ (id)bindModel:(CTEarnRankIndexModel *)model{
    CTEarnRankIndexViewModel *viewModel = [CTEarnRankIndexViewModel new];
    viewModel.uid = model.uid;
    viewModel.phone = model.phone;
    viewModel.headimg = model.headimg;
    viewModel.money = [NSString stringWithFormat:@"¥%@",model.money];
    return viewModel;
}

+ (NSArray *)bindModels:(NSArray *)models{
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < models.count;i ++){
        CTEarnRankIndexViewModel *viewModel = [self bindModel:models[i]];
        if(i < 3){
            viewModel.rankImage = [UIImage imageNamed:[NSString stringWithFormat:@"ic_level_%d",i + 1]];
            viewModel.showRankImage = YES;
        }
        else{
            viewModel.rank = [NSString stringWithFormat:@"%2d",i];
            viewModel.showRankImage = NO;
        }
        [array addObject:viewModel];
    }
    return array;
}

@end
