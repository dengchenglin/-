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
- (CLRequest *)fj_fqGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback;

//多品
- (CLRequest *)fj_fqMultipleGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback;

//宣传素材
- (CLRequest *)fj_fqMaterialGoodsWithMinId:(NSString *)minId callback:(CTResponseBlock )callback;

//快抢时间段
- (CLRequest *)fj_fastbuyCateWithCallback:(CTResponseBlock)callback;
//快抢列表
- (CLRequest *)fj_fastbuyGoodsWithCateId:(NSString *)cateId page:(NSInteger)page callback:(CTResponseBlock)callback;
@end

NS_ASSUME_NONNULL_END
