//
//  CTLoginBaseViewController.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

typedef NS_ENUM(NSInteger,CTEventKind) {
    CTEventKindRegister,
    CTEventKindForgetpsd,
    CTEventKindQQRegister,
    CTEventKindWechatRegister,
    CTEventKindWithDraw,
};

NSString *GetEventTitleStr(CTEventKind eventKind);

@interface CTLoginBaseViewController : CTBaseViewController

@end
