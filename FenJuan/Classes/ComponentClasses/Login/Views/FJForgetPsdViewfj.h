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
@interface FJForgetPsdViewfj : UIView
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (weak, nonatomic) IBOutlet CTPhoneTextField *mobileTfd;
@property (weak, nonatomic) IBOutlet CTCanValidButton *nextButton;

@end
