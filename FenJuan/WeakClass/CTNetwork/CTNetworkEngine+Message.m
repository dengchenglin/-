
//
//  CTNetworkEngine+Message.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Message.h"

#define CTMessage(path)   [CTUrlPath(@"message") stringByAppendingPathComponent:path]

NSString *GetMessageStr(CTMessageType type){
    switch (type) {
        case CTMessageAll:
            return @"消息";
            break;
        case CTMessageSystem:
            return @"系统消息";
            break;
        case CTMessageNotification:
            return @"通知消息";
            break;
        default:
            break;
    }
    return nil;
}

@implementation CTNetworkEngine (Message)

- (CLRequest *)messageIndexWithType:(CTMessageType)type page:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    [params setValue:@(type) forKey:@"type"];
    return [self postWithPath:CTMessage(@"index") params:params showHud:page>1?NO:YES callback:callback];
}
//推送设备token
- (CLRequest *)updateDeviceToken:(NSString *)deviceToken callback:(CTResponseBlock)callback{
    if(![CTAppManager logined])return nil;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:deviceToken forKey:@"device_token"];
    return [self postWithPath:CTMessage(@"update_device_token") params:params showHud:NO callback:callback];
}
@end
