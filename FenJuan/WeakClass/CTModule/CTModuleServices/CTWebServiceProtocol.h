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

- (UIViewController *)pushWebFromViewController:(UIViewController *)viewController htmlString:(NSString *)htmlString;

- (UIViewController *)pushWebFromViewController:(UIViewController *)viewController url:(NSString *)url;

- (UIViewController *)showWebFromViewController:(UIViewController *)viewController htmlString:(NSString *)htmlString;

- (UIViewController *)showWebFromViewController:(UIViewController *)viewController url:(NSString *)url;

- (UIViewController *)tbAuthFromViewController:(UIViewController *)viewController url:(NSString *)url callback:(void(^)(id data))callback;

- (void)tbAuthFromViewController:(UIViewController *)viewController completed:(void(^)(void))completed;
@end
