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

- (void)showLoginFormViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback;

- (void)pushWithdrawSetpsdFormViewController:(UIViewController *)viewController mobile:(NSString *)mobile completed:(void(^)(void))completed;

@end
