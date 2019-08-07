//
//  CTNetworkEngine+ThirldTk.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/11.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"


@interface CTNetworkEngine (ThirldTk)
//聚划算、淘抢购。。。
- (CLRequest *)getGoodsWithShopType:(CTShopType)type order:(CTGoodSortType)order page:(NSInteger)page minId:(NSString *)minId callback:(CTResponseBlock)callback;


//热卖商品
- (CLRequest *)hotSellingWithCateId:(NSString *)cateId saleType:(CTHotGoodsSaleType)saleType pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize callback:(CTResponseBlock)callback;

//达人说
- (CLRequest *)hdktalentcatWithTablentcat:(NSString *)talentcat callback:(CTResponseBlock)callback;
//商品详情列表
- (CLRequest *)hdkTalentcatDetailWithId:(NSString *)Id callback:(CTResponseBlock)callback;

//聚大牌主页
- (CLRequest *)hdkJdpWithCateId:(NSString *)cateId minId:(NSString *)minId callback:(CTResponseBlock)callback;

//聚大牌详情
- (CLRequest *)hdkJdpDetailWithId:(NSString *)Id minId:(NSString *)minId callback:(CTResponseBlock)callback;

//视频购
- (CLRequest *)hdkVideoBuyWithCateId:(NSString *)cateId minId:(NSString *)minId callback:(CTResponseBlock)callback;
@end

