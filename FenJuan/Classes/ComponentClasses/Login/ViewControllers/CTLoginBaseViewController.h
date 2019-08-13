//
//  CTLoginBaseViewController.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

#import "CTNetworkEngine+Login.h"

#import "UMShareManager.h"

typedef NS_ENUM(NSInteger,CTEventKind) {
    CTEventKindRegister,
    CTEventKindForgetpsd,
    CTEventKindQQRegister,
    CTEventKindWechatRegister,
    CTEventKindQQBind,
    CTEventKindWechatBind,
    CTEventKindWithDraw,
    CTEventKindBindAlipay
};

NSString *GetEventTitleStr(CTEventKind eventKind);

CTSendCodeType GetSendCodeStrForEventKind(CTEventKind eventKind);

CTEventKind GetEventKindWithLoginType(CTLoginType loginType);

@interface CTLoginBaseViewController : CTBaseViewController

@end
