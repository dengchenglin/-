//
//  CTDirectUserView.m
//  YouQuan
//
//  Created by dengchenglin on 2019/8/1.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTDirectUserView.h"

@implementation CTDirectUserView

- (void)setUser:(CTUser *)user{
    _user = user;
    [_userheadImageView sd_setImageWithURL:[NSURL URLWithString:_user.headimg] placeholderImage:[UIImage imageNamed:@"pic_head_placeholder"]];
    _usernameLabel.text = _user.nickname;
    _userLevelLabel.text = _user.level_txt;
    _recCountLabel.text = _user.people_num;
}
@end
