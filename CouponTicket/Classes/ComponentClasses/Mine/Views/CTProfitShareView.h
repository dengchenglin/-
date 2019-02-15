//
//  CTProfitShareView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTProfitShareView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userheadImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userlevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveBalanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *qrCodeLabel;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *usericon;
@property (nonatomic, copy) NSString *userlevel;
@property (nonatomic, copy) NSString *profit;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *qrCode;

@end
