//
//  CTCanValidButton.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTCanValidButton.h"

@implementation CTCanValidButton

ViewInstance(setUp)

- (void)setUp{
    self.clipsToBounds = YES;
    [self setBackgroundImage:[UIImage imageNamed:@"pic_bt_bg"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:CTLightGrayColor] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:RGBColor(153, 153, 153) forState:UIControlStateDisabled];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
