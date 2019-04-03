//
//  CTNetworkEngine+Member.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTNetworkEngine (Member)

//获取我的邀请码
- (NSString *)qCodeUrl;
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
- (CLRequest *)teamListWithCateId:(NSString *)cateId page:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback;
//热门分类和猜你喜欢
- (CLRequest *)hotGoodsCateWithCallback:(CTResponseBlock)callback;
//我的收藏
- (CLRequest *)myGoodsFavoriteWithPage:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback;
//设置提现密码
- (CLRequest *)setPaypwdWithPhone:(NSString *)phone pwd:(NSString *)pwd smsCode:(NSString *)smsCode callback:(CTResponseBlock)callback;
//意见反馈
- (CLRequest *)viewSaveWithDetail:(NSString *)detail img:(NSArray <NSString *>*)imgs callback:(CTResponseBlock)callback;
//收益明细
- (CLRequest *)incomeDetailWithCallback:(CTResponseBlock)callback;
//收益走势
- (CLRequest *)incomeTrendWithCallback:(CTResponseBlock)callback;
//用户详情
- (CLRequest *)teamUserDetailWithUid:(NSString *)uid callback:(CTResponseBlock)callback;
@end
