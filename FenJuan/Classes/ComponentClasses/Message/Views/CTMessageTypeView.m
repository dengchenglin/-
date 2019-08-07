//
//  CTMessageTypeView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMessageTypeView.h"

@implementation CTMessageTypeView

- (void)awakeFromNib{
    [super awakeFromNib];
    _backgroundView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    _backgroundView.layer.cornerRadius = 3.5;
    _backgroundView.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:104/255.0 blue:38/255.0 alpha:0.19].CGColor;
    _backgroundView.layer.shadowOffset = CGSizeMake(0.5,6);
    _backgroundView.layer.shadowOpacity = 1;
    _backgroundView.layer.shadowRadius = 10;
}

@end
