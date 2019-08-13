//
//  CTNetworkEngine+Recommend.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTNetworkEngine (Recommend)
//整点抢购时间列表
- (CLRequest *)fj_allTimeBuyWithCallback:(CTResponseBlock)callback;
//整点抢购商品列表
- (CLRequest *)fj_timeBuyGoodsWithPage:(NSInteger)page size:(NSInteger)size markeId:(NSString *)markeId callback:(CTResponseBlock)callback;
//视频购商品分类
- (CLRequest *)fj_videoBuyCateWithCallback:(CTResponseBlock)callback;
//视频购商品列表
- (CLRequest *)fj_videoBuyGoodsWithPage:(NSInteger)page size:(NSInteger)size cateId:(NSString *)cateId order:(NSString *)order callback:(CTResponseBlock)callback;
//官方精选
- (CLRequest *)fj_officialBuyWithPage:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback;
//官方精选详情
- (CLRequest *)fj_officialBuyDetailWithMarkeId:(NSString *)markeId callback:(CTResponseBlock)callback;
@end
