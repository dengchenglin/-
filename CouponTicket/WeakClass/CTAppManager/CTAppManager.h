//
//  CTAppManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTUser  :NSObject

@end

@interface CTAppManager : NSObject

@property (nonatomic, strong) CTUser *user;

SINGLETON_FOR_CLASS_DEF

+ (BOOL)logined;

@end
