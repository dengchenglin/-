//
//  CTMemberServiceProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol CTMemberServiceProtocol <NSObject,CLModuleServiceProtocol>
- (UIViewController *)memberEquityViewController;
@end
