//
//  CTRecListCell.m
//  YouQuan
//
//  Created by dengchenglin on 2019/8/1.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTRecListCell.h"

@implementation CTRecListCell

- (void)setUser:(CTUser *)user{
    _user = user;
    [_userheadImageView sd_setImageWithURL:[NSURL URLWithString:_user.headimg] placeholderImage:[UIImage imageNamed:@"pic_head_placeholder"]];
    _usernameLabel.text = _user.phone;
    _userLevelLabel.text = _user.level_txt;
}

@end
