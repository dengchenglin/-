//
//  CTMineHeadView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTMineHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (nonatomic, strong) CTUser *user;
@end
