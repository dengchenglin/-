//
//  CTNetworkEngine+Goods.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTNetworkEngine (Goods)
//商品详情
- (CLRequest *)goodsDetailWithId:(NSString *)Id callback:(CTResponseBlock)callback;

//获取商品链接（转链）
- (CLRequest *)goodsUrlConvertWithTbGoodId:(NSString *)tbGoodId callback:(CTResponseBlock)callback;

//搜索
- (CLRequest *)goodsSearchWithKeyword:(NSString *)keyword page:(NSInteger)page size:(NSInteger)size order:(NSString *)order callback:(CTResponseBlock)callback;
@end
