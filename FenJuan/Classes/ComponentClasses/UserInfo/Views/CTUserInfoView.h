//
//  CTUserInfoView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTUserInfoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userheadImageView;
@property (weak, nonatomic) IBOutlet UILabel *userlevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userkindLabel;

@property (nonatomic, strong) CTUser *user;
@end
