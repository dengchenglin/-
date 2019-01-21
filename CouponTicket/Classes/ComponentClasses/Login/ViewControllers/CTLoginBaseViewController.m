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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
