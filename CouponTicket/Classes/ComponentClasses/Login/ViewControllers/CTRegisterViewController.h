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

@property (nonatomic, strong) UMSocialUserInfoResponse *response;


@end
