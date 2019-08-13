//
//  CTMemberHeadView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJMemberHeadViewfj.h"

#import "CALayer+YYAdd.h"

@interface FJMemberHeadViewfj()


@end

@implementation FJMemberHeadViewfj

- (void)awakeFromNib{
    [super awakeFromNib];
    _equityBackgroundView.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_equity3"].CGImage;
    _equityBackgroundView.layer.shadowColor = [UIColor colorWithRed:128/255.0 green:102/255.0 blue:41/255.0 alpha:0.31].CGColor;
    _equityBackgroundView.layer.shadowOffset = CGSizeMake(0,2.5);
    _equityBackgroundView.layer.shadowOpacity = 1;
    _equityBackgroundView.layer.shadowRadius = 7;
}
- (void)setUser:(CTUser *)user{
    _user = user;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_user.headimg] placeholderImage:[UIImage imageNamed:@"pic_head_placeholder"]];
    _nameLabel.text = _user.nickname;
    _jobLabel.text = _user.level_txt;
}
@end
