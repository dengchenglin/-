//
//  CTNetworkEngine+Message.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

typedef NS_ENUM(NSInteger,CTMessageType){
    CTMessageAll = 0,
    CTMessageSystem,
    CTMessageNotification
};

NSString *GetMessageStr(CTMessageType type);

NS_ASSUME_NONNULL_BEGIN

@interface CTNetworkEngine (Message)

- (CLRequest *)messageIndexWithType:(CTMessageType)type page:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback;

@end

NS_ASSUME_NONNULL_END
