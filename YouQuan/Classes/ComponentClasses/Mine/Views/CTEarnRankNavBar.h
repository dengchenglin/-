//
//  CTEarnRankNavBar.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTEarnRankNavBar : UIView
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy)NSString  *title;
@property (nonatomic, assign) CGFloat backgroundAlpha;
@end
