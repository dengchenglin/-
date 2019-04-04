//
//  CTModuleHelper.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTActivityModel.h"

@interface CTModuleHelper : NSObject

+ (UIViewController *)showCtVcFromViewController:(UIViewController *)viewController model:(CTActivityModel *)model;

+ (UIViewController *)showViewControllerWithModel:(CTActivityModel *)model;

@end

