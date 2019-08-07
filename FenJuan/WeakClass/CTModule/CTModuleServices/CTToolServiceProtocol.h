//
//  CTToolServiceProtocol.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/30.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"


@protocol CTToolServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)questionViewController;

- (UIViewController *)syxViewController;
@end
