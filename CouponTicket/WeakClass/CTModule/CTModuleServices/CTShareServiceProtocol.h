//
//  CTShareServiceProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol CTShareServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)pushShareFromViewController:(UIViewController *)viewController;

@end
