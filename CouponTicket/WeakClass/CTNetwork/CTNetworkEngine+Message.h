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


@interface CTNetworkEngine (Message)

//消息列表
- (CLRequest *)messageIndexWithType:(CTMessageType)type page:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback;
//推送设备token
- (CLRequest *)updateDeviceToken:(NSString *)deviceToken callback:(CTResponseBlock)callback;
@end

