//
//  CTGetCodeView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CLTimerButton.h"

#import "CTCanValidButton.h"
#import "CTPhoneTextField.h"
@interface CTGetCodeView : UIView
@property (weak, nonatomic) IBOutlet CTPhoneTextField *phoneTfd;
@property (weak, nonatomic) IBOutlet UITextField *codeTfd;
@property (weak, nonatomic) IBOutlet CLTimerButton *getCodeButton;
@property (weak, nonatomic) IBOutlet CTCanValidButton *nextButton;

@end
