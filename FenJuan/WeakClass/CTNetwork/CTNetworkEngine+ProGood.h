//
//  CTNetworkEngine+ProGood.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTNetworkEngine (ProGood)
//发圈
- (CLRequest *)fqGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback;

//多品
- (CLRequest *)fqMultipleGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback;

//宣传素材
- (CLRequest *)fqMaterialGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback;

//快抢时间段
- (CLRequest *)fastbuyCateWithCallback:(CTResponseBlock)callback;
//快抢列表
- (CLRequest *)fastbuyGoodsWithCateId:(NSString *)cateId page:(NSInteger)page callback:(CTResponseBlock)callback;
@end

NS_ASSUME_NONNULL_END
