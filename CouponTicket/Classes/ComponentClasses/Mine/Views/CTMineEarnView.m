//
//  CTMineEarnView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMineEarnView.h"

@implementation CTMineEarnView

- (void)awakeFromNib{
    [super awakeFromNib];
    _earnButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    self.layer.cornerRadius = 10;
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,8);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 17.5;
    
}

@end
