//
//  CTLoginServiceProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol CTLoginServiceProtocol <NSObject,CLModuleServiceProtocol>

- (void)showLoginFromViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback;

- (void)pushWithdrawSetpsdFromViewController:(UIViewController *)viewController mobile:(NSString *)mobile completed:(void(^)(void))completed;

- (void)pushBoundAlipayFromViewController:(UIViewController *)viewController completed:(void(^)(void))completed;

@end
