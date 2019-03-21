//
//  CTTeamListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTTeamListCell.h"

@implementation CTTeamListCell

- (void)setUser:(CTUser *)user{
    _user = user;
    [_userheadImageView sd_setImageWithURL:[NSURL URLWithString:_user.headimg] placeholderImage:[UIImage imageNamed:@"pic_head_placeholder"]];
    _usernameLabel.text = _user.nickname;
    _userLevelLabel.text = _user.level_txt;
    _userKindLabel.text = _user.type;
}
@end
