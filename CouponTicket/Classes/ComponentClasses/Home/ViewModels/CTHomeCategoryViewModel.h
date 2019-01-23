//
//  CTHomeCategoryViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

#import "CTCategoryModel.h"

typedef NS_ENUM(NSInteger,CTGoodSortType) {
    CTGoodSortComprehensive,    //综合
    CTGoodSortSales,            //销量
    CTGoodSortNewest,           //最新
    CTGoodSortDiscountUp,       //折扣力度升序
    CTGoodSortDiscountDown,     //折扣力度降序
    CTGoodSortPriceUp,          //价格升序
    CTGoodSortPriceDown,        //介个降序
};

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
