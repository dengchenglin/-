//
//  CTNetworkEngine+BoundPayAccount.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/29.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTNetworkEngine (Cash)
//绑定支付宝
- (CLRequest *)fj_accountSaveWithAccount:(NSString *)account username:(NSString *)username phone:(NSString *)phone smsCode:(NSString *)smsCode callback:(CTResponseBlock)callback;
//提现页面
- (CLRequest *)fj_cashIndexWithCallback:(CTResponseBlock)callback;
//提现
- (CLRequest *)fj_cashSaveWithPaypwd:(NSString *)paypwd money:(NSString *)money callback:(CTResponseBlock)callback;
//提现记录
- (CLRequest *)fj_cashLogWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize callback:(CTResponseBlock)callback;
@end
