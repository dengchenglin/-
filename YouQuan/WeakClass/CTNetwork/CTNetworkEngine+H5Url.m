
//
//  CTNetworkEngine+H5Url.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/26.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+H5Url.h"

NSString *GetH5UrlPath(CTH5UrlType type){
    switch (type) {
        case CTH5UrlRegAgreement:
            return @"zcxy";
            break;
        case CTH5UrlAbountUs:
            return @"gywm";
            break;
        case CTH5UrlMakeMoneyStrategy:
            return @"zqgl";
            break;
        case CTH5UrlSaveMoneyStrategy:
            return @"sqgl";
            break;
        case CTH5UrlGetTikcetAuide:
            return @"lqzn";
            break;
        default:
            break;
    }
    return @"";
}

@implementation CTNetworkEngine (H5Url)

- (NSString *)h5urlForType:(CTH5UrlType)type{
    NSString *path = [NSString stringWithFormat:@"api/rich/index?type=%@",GetH5UrlPath(type)];
    return CTBaseUrl(path);
}

@end
