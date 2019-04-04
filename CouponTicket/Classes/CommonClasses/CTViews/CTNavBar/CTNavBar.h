//
//  CTNavBar.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTNavBar : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, copy)NSString  *title;

@end
