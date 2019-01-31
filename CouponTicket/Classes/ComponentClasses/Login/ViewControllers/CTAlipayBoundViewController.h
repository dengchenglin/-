//
//  CTAlipayBoundViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginBaseViewController.h"

@interface CTAlipayBoundViewController : CTLoginBaseViewController

@property (nonatomic, copy) void(^completed)(void);

@end
