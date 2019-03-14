//
//  CTHomeCategoryViewModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeCategoryViewModel.h"

@implementation CTHomeCategoryViewModel

- (NSMutableArray<CTGoodsModel *> *)dataSoures{
    if(!_dataSoures){
        _dataSoures = [NSMutableArray array];
    }
    return _dataSoures;
}

@end
