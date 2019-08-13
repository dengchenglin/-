//
//  CTLoginViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginBaseViewController.h"

@interface FJLoginViewControllerfj : CTLoginBaseViewController
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
+ (void)showLoginFormViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback;

@end
