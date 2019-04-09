//
//  MWManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MWManager : NSObject

+ (void)initSDK;

+ (void)routeMlink:(NSURL *)url;

+ (BOOL)continueUserActivity:(nonnull NSUserActivity *)userActivity;

@end
