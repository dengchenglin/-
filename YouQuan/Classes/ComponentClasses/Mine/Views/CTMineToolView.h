//
//  CTMineToolView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTMineToolView : UIView

@property (weak, nonatomic) IBOutlet UIView *teamView;
@property (weak, nonatomic) IBOutlet UIView *collectView;
@property (weak, nonatomic) IBOutlet UIView *guideView;
@property (weak, nonatomic) IBOutlet UIView *inviteCodeView;
@property (weak, nonatomic) IBOutlet UIView *questionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *teamHeight;

@end
