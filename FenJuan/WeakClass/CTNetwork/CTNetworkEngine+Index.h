//
//  CTNetworkEngine+Index.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTNetworkEngine (Index)

//首页数据
- (CLRequest *)indexWithCallback:(CTResponseBlock)callback isCaches:(BOOL)isCaches;
//当前整点抢购
- (CLRequest *)fj_curTimeBuyWithTime:(NSString *)time callback:(CTResponseBlock)callback;
//二级分类
- (CLRequest *)cateWithPid:(NSString *)pid callback:(CTResponseBlock)callback;

//分类商品

- (CLRequest *)fj_cateGoodsWithPage:(NSInteger)page size:(NSInteger)size cateId:(NSString *)cateId order:(NSString *)order callback:(CTResponseBlock)callback;

- (CLRequest *)fj_cateGoodsWithPage:(NSInteger)page size:(NSInteger)size cateId:(NSString *)cateId order:(NSString *)order showHud:(BOOL)showHud callback:(CTResponseBlock)callback;

//分类获取
- (CLRequest *)_cateWithPid:(NSString *)pid callback:(CTResponseBlock)callback;
- (CLRequest *)cateWithPid:(NSString *)pid callback:(CTResponseBlock)callback cachesType:(CTNetCachesType)cachesType;



//活动商品列表
- (CLRequest *)activityGoodsWithPage:(NSInteger)page size:(NSInteger)size activityId:(NSString *)activityId order:(NSString *)order callback:(CTResponseBlock)callback;
//实时热销榜
- (CLRequest *)hotGoodsWithCallback:(CTResponseBlock)callback;
@end
