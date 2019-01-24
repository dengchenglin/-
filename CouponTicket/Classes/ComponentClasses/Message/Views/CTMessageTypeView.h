//
//  CTMessageTypeView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTMessageTypeView : UIView
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UIView *systemMessageView;
@property (weak, nonatomic) IBOutlet UIView *notificationMessageView;

@end
