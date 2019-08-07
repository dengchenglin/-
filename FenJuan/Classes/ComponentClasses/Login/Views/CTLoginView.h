//
//  CTLoginView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCanValidButton.h"
#import "CTPhoneTextField.h"
@interface CTLoginView : UIView
@property (weak, nonatomic) IBOutlet CTPhoneTextField *accountTfd;
@property (weak, nonatomic) IBOutlet UITextField *passwordTfd;
@property (weak, nonatomic) IBOutlet CTCanValidButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *wechatButton;
@property (weak, nonatomic) IBOutlet UIButton *qqButton;
@property (weak, nonatomic) IBOutlet UIButton *agreementButton;

@end
