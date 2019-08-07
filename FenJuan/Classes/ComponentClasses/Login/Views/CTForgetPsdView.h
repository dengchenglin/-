//
//  CTForgetPsdView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/21.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTCanValidButton.h"
#import "CTPhoneTextField.h"
@interface CTForgetPsdView : UIView

@property (weak, nonatomic) IBOutlet CTPhoneTextField *mobileTfd;
@property (weak, nonatomic) IBOutlet CTCanValidButton *nextButton;

@end
