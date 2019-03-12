//
//  CTHomeModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTCategoryModel.h"

#import "CTGoodsModel.h"

#import "CTActivityModel.h"

@interface CTHomeCurTimeBuyModel:NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *next_time;
@property (nonatomic, copy) NSArray <CTGoodsModel *> *goods;


@end

@interface CTHomeModel : NSObject
//一级分类
@property (nonatomic, copy) NSArray <CTCategoryModel *> *cate;
//活动数据
@property (nonatomic, copy) NSArray <CTActivityModel *> *activity;
//活动广告数据
@property (nonatomic, copy) NSArray <CTActivityModel *> *activity_banner;
//广告数据
@property (nonatomic, copy) NSArray <CTActivityModel *> *advs;
//整点抢购数据
@property (nonatomic, strong) CTHomeCurTimeBuyModel *cur_time_buy;
//上新数据
@property (nonatomic, copy) NSArray <CTGoodsModel *> *now_goods;
@end
