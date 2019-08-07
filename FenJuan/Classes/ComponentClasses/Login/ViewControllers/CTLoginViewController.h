//
//  CTLoginViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginBaseViewController.h"

@interface CTLoginViewController : CTLoginBaseViewController

+ (void)showLoginFormViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback;

@end
