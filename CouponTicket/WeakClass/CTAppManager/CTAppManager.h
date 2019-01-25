//
//  CTAppManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTAppManager : NSObject

SINGLETON_FOR_CLASS_DEF

+ (BOOL)logined;

@end
