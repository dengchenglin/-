//
//  CTRegisterView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCanValidButton.h"
#import "CTPhoneTextField.h"
@interface CTRegisterView : UIView
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTfd;
@property (weak, nonatomic) IBOutlet CTPhoneTextField *phoneTfd;
@property (weak, nonatomic) IBOutlet CTCanValidButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@end
