//
//  CTSetPasswordViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginBaseViewController.h"

@interface CTSetPasswordViewController : CTLoginBaseViewController

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) CTEventKind eventKind;

@property (nonatomic, copy) void(^completed)(void);

@end
