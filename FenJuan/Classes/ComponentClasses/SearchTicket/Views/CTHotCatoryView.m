//
//  CTHotCatoryView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHotCatoryView.h"

#import "CTMainCategoryItem.h"

@implementation CTHotCatoryView
- (void)setCategoryModels:(NSArray<CTCategoryModel *> *)categoryModels{
    _categoryModels = [categoryModels copy];
    self.categoryView.categoryModels = _categoryModels;
}

@end
