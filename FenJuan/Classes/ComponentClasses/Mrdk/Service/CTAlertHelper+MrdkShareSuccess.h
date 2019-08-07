//
//  CTAlertHelper+MrdkShareSuccess.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlertHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTAlertHelper (MrdkShareSuccess)
+ (void)showMrdkShareSuccessWithCallback:(nullable void(^)(NSUInteger index))callback;
@end

NS_ASSUME_NONNULL_END
