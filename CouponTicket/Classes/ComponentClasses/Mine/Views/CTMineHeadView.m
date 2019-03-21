//
//  CTMineHeadView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMineHeadView.h"

@implementation CTMineHeadView

- (void)setUser:(CTUser *)user{
    _user = user;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_user.headimg] placeholderImage:[UIImage imageNamed:@"pic_head_placeholder"]];
    _nameLabel.text = _user.nickname;
    _jobLabel.text = _user.level_txt;
}

@end
