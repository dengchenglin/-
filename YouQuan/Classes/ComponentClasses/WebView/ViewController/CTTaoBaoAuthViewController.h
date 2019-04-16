//
//  CTTaoBaoAuthViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTTaoBaoAuthViewController : CTBaseViewController

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) void(^callback)(id data);

+ (UIViewController *)tbAuthFromViewController:(UIViewController *)viewController url:(NSString *)url callback:(void (^)(id data))callback;

@end