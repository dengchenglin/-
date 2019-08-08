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

#import "CTGoodsModel.h"

@interface CTHomeCategoryViewModel : CTViewModel

//主分类Id
@property (nonatomic, copy) NSString *main_category_id;
//子分类id
@property (nonatomic, copy) NSString *sub_category_id;
//排序方式
@property (nonatomic, assign) CTGoodSortType sortType;

@property (nonatomic, copy) NSString *order;

@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@end
