//
//  CTGetCodeViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginBaseViewController.h"

@interface CTGetCodeViewController : CTLoginBaseViewController
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *inviteCode;

@property (nonatomic, copy) NSString *cashAccount;

@property (nonatomic, copy) NSString *cashName;

@property (nonatomic, strong) CTUMSocialUserInfoResponse *response;

@property (nonatomic, assign) CTEventKind eventKind;

@property (nonatomic, copy) void(^completed)(void);

@end
