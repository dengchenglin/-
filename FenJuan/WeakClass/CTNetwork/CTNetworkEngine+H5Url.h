//
//  CTNetworkEngine+H5Url.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/26.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

#define CTH5UrlForType(type) [CTRequest h5urlForType:type]

typedef NS_ENUM(NSInteger,CTH5UrlType){
    CTH5UrlRegAgreement,      //用户注册协议
    CTH5UrlAbountUs,          //关于我们
    CTH5UrlMakeMoneyStrategy, //赚钱攻略
    CTH5UrlSaveMoneyStrategy, //省钱攻略
    CTH5UrlGetTikcetAuide,     //领券指南
    CTH5UrlWithdrawIntro      //查看提现说明
};
NSString *GetH5UrlPath(CTH5UrlType type);

NS_ASSUME_NONNULL_BEGIN

@interface CTNetworkEngine (H5Url)

- (NSString *)h5urlForType:(CTH5UrlType)type;

@end

NS_ASSUME_NONNULL_END
