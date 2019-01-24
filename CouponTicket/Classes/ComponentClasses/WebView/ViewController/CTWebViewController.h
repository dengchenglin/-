//
//  CTWebViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTWebViewController : CTBaseViewController

+ (UIViewController *)showWebFromViewController:(UIViewController *)viewController url:(NSString *)url htmlString:(NSString *)htmlString isPush:(BOOL)isPush;

@end
