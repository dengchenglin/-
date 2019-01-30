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
            break;
        default:
            break;
    }
    return @"";
}


@interface CTLoginBaseViewController ()

@end

@implementation CTLoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarStyle = CTNavigationBarWhite;
}



@end
