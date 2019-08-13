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

- (Class)rootBaseClass;

- (void)fj_showLoginFromViewController:(UIViewController *)viewController success:(void(^)(void))success failure:(void(^)(void))failure;

- (void)fj_showLoginFromViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback;

- (void)fj_pushWithdrawSetpsdFromViewController:(UIViewController *)viewController mobile:(NSString *)mobile completed:(void(^)(void))completed;

- (void)fj_pushBoundAlipayFromViewController:(UIViewController *)viewController completed:(void(^)(void))completed;

- (void)fj_judgeLoginWithViewController:(UIViewController *)viewController completed:(void(^)(void))completed;

- (void)fj_showRegisterFromViewController:(UIViewController *)viewController  inviteCode:(NSString *)inviteCode callback:(void(^)(BOOL logined))callback;
@end
