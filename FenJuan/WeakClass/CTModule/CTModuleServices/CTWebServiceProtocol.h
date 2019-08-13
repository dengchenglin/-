//
//  CTWebServiceProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol CTWebServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)fj_pushWebFromViewController:(UIViewController *)viewController htmlString:(NSString *)htmlString;

- (UIViewController *)fj_pushWebFromViewController:(UIViewController *)viewController url:(NSString *)url;

- (UIViewController *)fj_showWebFromViewController:(UIViewController *)viewController htmlString:(NSString *)htmlString;

- (UIViewController *)fj_showWebFromViewController:(UIViewController *)viewController url:(NSString *)url;

- (UIViewController *)fj_tbAuthFromViewController:(UIViewController *)viewController url:(NSString *)url callback:(void(^)(id data))callback;

- (void)fj_tbAuthFromViewController:(UIViewController *)viewController completed:(void(^)(void))completed;
@end
