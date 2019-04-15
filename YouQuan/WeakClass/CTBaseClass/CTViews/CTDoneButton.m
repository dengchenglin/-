//
//  CTDoneButton.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTDoneButton.h"

@implementation CTDoneButton

ViewInstance(setUp)

- (void)setUp{
    self.clipsToBounds = YES;
    [self setBackgroundImage:[UIImage imageNamed:@"pic_bt_bg"] forState:UIControlStateNormal];
    self.titleLabel.font = CTPsbFont(16);
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
