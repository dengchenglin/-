//
//  CTSetPasswordView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCanValidButton.h"
#import "CLTextField.h"
@interface CTSetPasswordView : UIView
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (weak, nonatomic) IBOutlet CLTextField *passwordTfd;
@property (weak, nonatomic) IBOutlet CLTextField *repasswordTfd;
@property (weak, nonatomic) IBOutlet CTCanValidButton *doneButton;
@end
