//
//  CTSetPasswordView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCanValidButton.h"
@interface CTSetPasswordView : UIView
@property (weak, nonatomic) IBOutlet UITextField *passwordTfd;
@property (weak, nonatomic) IBOutlet UITextField *repasswordTfd;
@property (weak, nonatomic) IBOutlet CTCanValidButton *doneButton;
@end
