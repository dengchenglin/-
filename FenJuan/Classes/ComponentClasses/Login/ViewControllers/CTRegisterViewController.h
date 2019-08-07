//
//  CTRegisterViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginBaseViewController.h"

@interface CTRegisterViewController : CTLoginBaseViewController

@property (nonatomic, assign) CTEventKind eventKind;

@property (nonatomic, strong) CTUMSocialUserInfoResponse *response;

@property (nonatomic, copy) NSString *inviteCode;
@property (nonatomic, copy) void(^completed)(void);
@end
