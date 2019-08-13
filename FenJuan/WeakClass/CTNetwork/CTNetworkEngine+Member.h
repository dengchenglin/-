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
- (CLRequest *)fj_userIndexWithCallback:(CTResponseBlock)callback;
//会员权益
- (CLRequest *)fj_userPowerWithCallback:(CTResponseBlock)callback;
//我的收益
- (CLRequest *)fj_userInfoWithCallback:(CTResponseBlock)callback;
//常见问题
- (CLRequest *)fj_oftenProblemWithPage:(NSInteger)page size:(NSInteger)size name:(NSString *)name callback:(CTResponseBlock)callback;
//我的团队-分类
- (CLRequest *)fj_teamCateWithCallback:(CTResponseBlock)callback;
//我的团队-列表
- (CLRequest *)fj_teamListWithCateId:(NSString *)cateId page:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback;
//热门分类和猜你喜欢
- (CLRequest *)fj_hotGoodsCateWithCallback:(CTResponseBlock)callback;
//我的收藏
- (CLRequest *)fj_myGoodsFavoriteWithPage:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback;
//设置提现密码
- (CLRequest *)fj_setPaypwdWithPhone:(NSString *)phone pwd:(NSString *)pwd smsCode:(NSString *)smsCode callback:(CTResponseBlock)callback;
//意见反馈
- (CLRequest *)fj_viewSaveWithDetail:(NSString *)detail img:(NSArray <NSString *>*)imgs callback:(CTResponseBlock)callback;
//收益明细
- (CLRequest *)fj_incomeDetailWithCallback:(CTResponseBlock)callback;
//收益走势
- (CLRequest *)fj_incomeTrendWithCallback:(CTResponseBlock)callback;
//用户详情
- (CLRequest *)fj_teamUserDetailWithUid:(NSString *)uid callback:(CTResponseBlock)callback;
//会员编辑信息
- (CLRequest *)fj_userInfoSaveWithInfo:(NSDictionary *)info callback:(CTResponseBlock)callback;
//收益排行
- (CLRequest *)fj_icomenRankWithCallback:(CTResponseBlock)callback;
//邀请分享
- (CLRequest *)fj_shareInfoWithCallback:(CTResponseBlock)callback;
//获取淘宝授权链接
- (CLRequest *)fj_tbAuthWithCallback:(CTResponseBlock)callback;
//我的团队-备注下级用户
- (CLRequest *)fj_childRemarkSaveWithChildUid:(NSString *)childUid remark:(NSString *)remark callback:(CTResponseBlock)callback;
@end
