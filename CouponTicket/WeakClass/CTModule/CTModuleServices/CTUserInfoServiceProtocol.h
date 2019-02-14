//
//  CTUserInfoServiceProtocol.h
//  CouponTicket
//
//  Created by Dankal on 2019/2/14.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol CTUserInfoServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)viewControllerForUserId:(NSString *)userId;

@end
