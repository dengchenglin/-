//
//  QCodeHelper.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCodeHelper : NSObject

+ (void)showQcodeFromViewController:(UIViewController *)viewController discernCallback:(void(^)(NSString *result))discernCallback;

@end
