//
//  CTShareView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTShareView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *inviteCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UIView *preView;
@end
