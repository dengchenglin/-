//
//  CTNetworkEngine+Mrdk.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/26.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CTMrdkPayType){
    CTMrdkPayAmount = 1,
    CTMrdkPayAlipay,
    CTMrdkPayWechat
};

@interface CTNetworkEngine (Mrdk)
//打卡首页
- (CLRequest *)mrdkIndexWithCallback:(CTResponseBlock)callback;
//我的记录
- (CLRequest *)mrdkRecordWithCallback:(CTResponseBlock)callback;
//报名
- (CLRequest *)sa_regWithPayType:(CTMrdkPayType)payType money:(NSString *)money password:(nullable NSString *)password activityId:(NSString *)activityId callback:(CTResponseBlock)callback;
//打卡
- (CLRequest *)sa_signInWithCallback:(CTResponseBlock)callback;
@end

NS_ASSUME_NONNULL_END
