//
//  CTWithdrawServiceProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol CTWithdrawServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)pushCashFromViewController:(UIViewController *)viewController;

@end
