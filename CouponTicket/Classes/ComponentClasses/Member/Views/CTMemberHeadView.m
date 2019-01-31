//
//  CTMemberHeadView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMemberHeadView.h"

#import "CALayer+YYAdd.h"

@interface CTMemberHeadView()


@end

@implementation CTMemberHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    _equityBackgroundView.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_equity3"].CGImage;
    _equityBackgroundView.layer.shadowColor = [UIColor colorWithRed:128/255.0 green:102/255.0 blue:41/255.0 alpha:0.31].CGColor;
    _equityBackgroundView.layer.shadowOffset = CGSizeMake(0,2.5);
    _equityBackgroundView.layer.shadowOpacity = 1;
    _equityBackgroundView.layer.shadowRadius = 7;
}

@end
