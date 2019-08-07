//
//  CTMineBalanceView.m
//  YouQuan
//
//  Created by dengchenglin on 2019/7/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMineBalanceView.h"

@implementation CTMineBalanceView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,8);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 17.5;
}
- (void)setUser:(CTUser *)user{
    _user = user;
    _balanceLabel.text = _user.money;
}
@end
