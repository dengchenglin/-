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
@property (nonatomic, assign) BOOL checked;
+ (NSArray <CTGoodsImgModel *>*)modelsWithDatas:(NSDictionary *)datas;
- (void)checkAndAmendWithRealSize:(CGSize)realSize;
@end

@interface CTNetworkEngine (Goods)
//商品详情
- (CLRequest *)goodsDetailWithId:(NSString *)Id callback:(CTResponseBlock)callback;

//获取商品链接（转链）
- (CLRequest *)fj_goodsUrlConvertWithTbGoodsInfo:(NSDictionary *)goodsInfo callback:(CTResponseBlock)callback;

//搜索
- (CLRequest *)fj_goodsSearchWithKeyword:(NSString *)keyword page:(NSInteger)page size:(NSInteger)size order:(NSString *)order callback:(CTResponseBlock)callback;
//商品收藏
- (CLRequest *)fj_favoriteWithGoodsId:(NSString *)goodsId isFavorite:(BOOL)isFavorite callback:(CTResponseBlock)callback;
//热搜和搜索历史
- (CLRequest *)fj_searchHistoryWithCallback:(CTResponseBlock)callback;
//获取商品图片
- (CLRequest *)fj_goodsImgWithItemId:(NSString *)itemId callback:(CTResponseBlock)callback;

//获取店铺信息
- (CLRequest *)fj_storeInfoWithItemId:(NSString *)itemId callback:(CTResponseBlock)callback;
//商品分享编辑页面
- (CLRequest *)goodsShareWithId:(NSString *)Id callback:(CTResponseBlock)callback;

//商品分享编辑页面
- (CLRequest *)goodsShareWithId:(NSString *)Id kind:(CTShopKind)kind callback:(CTResponseBlock)callback;
@end
