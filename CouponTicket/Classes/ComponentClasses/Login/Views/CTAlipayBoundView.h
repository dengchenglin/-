//
//  CTAlipayBoundView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCanValidButton.h"
@interface CTAlipayBoundView : UIView
@property (weak, nonatomic) IBOutlet UITextField *accountTfd;
@property (weak, nonatomic) IBOutlet UITextField *nameTfd;
@property (weak, nonatomic) IBOutlet CTCanValidButton *boundButton;
@end
