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

@property (nonatomic, copy) NSString *inviteCode;

@property (nonatomic, copy) NSString *verCode;

@property (nonatomic, copy) NSString *openid;

@property (nonatomic, copy) NSString *unionid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *iconurl;

@property (nonatomic, copy) void(^completed)(void);

@end
