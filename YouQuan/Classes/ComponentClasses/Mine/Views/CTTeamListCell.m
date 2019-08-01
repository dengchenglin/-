//
//  CTTeamListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTTeamListCell.h"

@implementation CTTeamListCell

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [self.recCountView addActionWithBlock:^(id target) {
        @strongify(self)
        if(self.delegate && [self.delegate respondsToSelector:@selector(didClickRecWithIndex:)]){
            [self.delegate didClickRecWithIndex:self.index];
        }
    }];
}

- (void)setUser:(CTUser *)user{
    _user = user;
    [_userheadImageView sd_setImageWithURL:[NSURL URLWithString:_user.headimg] placeholderImage:[UIImage imageNamed:@"pic_head_placeholder"]];
    _usernameLabel.text = _user.nickname;
    _userLevelLabel.text = _user.level_txt;
    _userKindLabel.text = _user.type;
    
    _recCountView.hidden = !_user.people_num.integerValue;
    _recCountLabel.text = _user.people_num;
}
@end
