//
//  CTNetworkEngine+Goods.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTGoodsImgModel:NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, strong) NSValue *size;
+ (NSArray <CTGoodsImgModel *>*)modelsWithDatas:(NSDictionary *)datas;
@end

@interface CTNetworkEngine (Goods)
//商品详情
- (CLRequest *)goodsDetailWithId:(NSString *)Id callback:(CTResponseBlock)callback;

//获取商品链接（转链）
- (CLRequest *)goodsUrlConvertWithTbGoodsInfo:(NSDictionary *)goodsInfo callback:(CTResponseBlock)callback;

//搜索
- (CLRequest *)goodsSearchWithKeyword:(NSString *)keyword page:(NSInteger)page size:(NSInteger)size order:(NSString *)order callback:(CTResponseBlock)callback;
//商品收藏
- (CLRequest *)favoriteWithGoodsId:(NSString *)goodsId isFavorite:(BOOL)isFavorite callback:(CTResponseBlock)callback;
//热搜和搜索历史
- (CLRequest *)searchHistoryWithCallback:(CTResponseBlock)callback;
//获取商品图片
- (CLRequest *)goodsImgWithItemId:(NSString *)itemId callback:(CTResponseBlock)callback;
@end
