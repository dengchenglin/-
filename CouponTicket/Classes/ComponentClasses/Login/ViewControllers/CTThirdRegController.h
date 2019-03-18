//
//  CTThirdRegController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPageController.h"

#import "CTLoginBaseViewController.h"

@interface CTThirdRegController : CTPageController

@property (nonatomic, assign) CTEventKind eventKind;

@property (nonatomic, strong) CTUMSocialUserInfoResponse *response;

@end
