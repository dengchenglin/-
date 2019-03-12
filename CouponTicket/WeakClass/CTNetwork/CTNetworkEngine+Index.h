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
- (CLRequest *)indexWithCallback:(CTResponseBlock)callback;
//当前整点抢购
- (CLRequest *)curTimeBuyWithTime:(NSString *)time callback:(CTResponseBlock)callback;
//二级分类
- (CLRequest *)cateWithCallback:(CTResponseBlock)callback;
//分类商品
- (CLRequest *)cateGoodsWithPage:(NSInteger)page size:(NSInteger)size cateId:(NSString *)cateId order:(NSString *)order callback:(CTResponseBlock)callback;
@end
