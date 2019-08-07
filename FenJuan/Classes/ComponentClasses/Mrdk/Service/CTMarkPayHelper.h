//
//  CTMarkPayHelper.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTNetworkEngine+Mrdk.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMarkPayHelper : NSObject

+ (void)payWithType:(CTMrdkPayType)type amount:(NSString *)amount activityId:(NSString *)activityId success:(void(^)(id value))success;
@end

NS_ASSUME_NONNULL_END
