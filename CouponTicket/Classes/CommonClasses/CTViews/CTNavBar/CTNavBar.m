//
//  CTNavBar.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNavBar.h"

@implementation CTNavBar

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = _title;
}

@end
