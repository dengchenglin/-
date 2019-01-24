//
//  CTHomeCategoryViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

#import "CTCategoryModel.h"

#import "CTGoodDefine.h"

@interface CTHomeCategoryViewModel : CTViewModel

//子分类集
@property (nonatomic, copy) NSArray <CTCategoryModel *>*subCategoryModels;

//主分类Id
@property (nonatomic, copy) NSString *main_category_id;
//子分类id
@property (nonatomic, copy) NSString *sub_category_id;
//排序方式
@property (nonatomic, assign) CTGoodSortType sortType;

@end
