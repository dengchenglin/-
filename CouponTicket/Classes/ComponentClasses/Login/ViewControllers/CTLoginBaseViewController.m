//
//  CTLoginBaseViewController.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTLoginBaseViewController.h"

NSString *GetEventTitleStr(CTEventKind eventKind){
    switch (eventKind) {
        case CTEventKindRegister:
            return @"手机快速注册";
            break;
        case CTEventKindForgetpsd:
            return @"找回密码";
            break;
        case CTEventKindQQRegister:
            return @"QQ快速注册";
            break;
        case CTEventKindWechatRegister:
            return @"微信快速注册";
        case CTEventKindQQBind:
            return @"QQ账号绑定";
            break;
        case CTEventKindWechatBind:
            return @"微信账号绑定";
            break;
        case CTEventKindWithDraw:
            return @"设置提现密码";
            break;
        default:
            break;
    }
    return @"";
}

CTSendCodeType GetSendCodeStrForEventKind(CTEventKind eventKind){
    switch (eventKind) {
        case CTEventKindRegister:
            return CTSendCodeRegister;
            break;
        case CTEventKindQQRegister:
            return CTSendCodeRegister;
            break;
        case CTEventKindWechatRegister:
            return CTSendCodeRegister;
            break;
        case CTEventKindQQBind:
            return CTSendCodeResetinfo;
            break;
        case CTEventKindWechatBind:
            return CTSendCodeResetinfo;
            break;
        case CTEventKindForgetpsd:
            return CTSendCodeResetpwd;
            break;
        case CTEventKindWithDraw:
            return CTSendCodeResetinfo;
            break;
        default:
            break;
    }
    return 0;
}

CTEventKind GetEventKindWithLoginType(CTLoginType loginType){
    switch (loginType) {
        case CTLoginPhone:
            return CTEventKindRegister;
            break;
        case CTLoginWeChat:
            return CTEventKindWechatRegister;
            break;
        case CTLoginQQ:
            return CTEventKindQQRegister;
            break;
        default:
            break;
    }
    return 0;
}

@interface CTLoginBaseViewController ()

@end

@implementation CTLoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarStyle = CTNavigationBarWhite;
}



@end
