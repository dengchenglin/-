//
//  CTBindPhoneView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTCanValidButton.h"
#import "CTPhoneTextField.h"
@interface CTBindPhoneView : UIView

@property (weak, nonatomic) IBOutlet CTPhoneTextField *mobileTfd;
@property (weak, nonatomic) IBOutlet CTCanValidButton *nextButton;

@end
