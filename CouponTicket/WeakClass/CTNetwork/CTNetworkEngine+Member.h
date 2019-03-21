//
//  CTNetworkEngine+Member.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTNetworkEngine (Member)

//会员信息
- (CLRequest *)userIndexWithCallback:(CTResponseBlock)callback;
//会员权益
- (CLRequest *)userPowerWithCallback:(CTResponseBlock)callback;
//我的收益
- (CLRequest *)userInfoWithCallback:(CTResponseBlock)callback;
//常见问题
- (CLRequest *)oftenProblemWithPage:(NSInteger)page size:(NSInteger)size name:(NSString *)name callback:(CTResponseBlock)callback;
//我的团队-分类
- (CLRequest *)teamCateWithCallback:(CTResponseBlock)callback;
//我的团队-列表
- (CLRequest *)teamListWithCateId:(NSString *)cateId page:(NSInteger)page size:(NSInteger)size  callback:(CTResponseBlock)callback;
@end
