//
//  CTAlipayBoundViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginBaseViewController.h"

@interface FJAlipayBoundViewControllerfj : CTLoginBaseViewController
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, copy) void(^completed)(void);

@end
