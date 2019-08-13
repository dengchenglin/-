//
//  CTThirtyProfitView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTThirtyProfitView.h"

@implementation CTThirtyProfitView

- (void)setModel:(FJEarnTrendModelfj *)model{
    _model = model;
    _profitLabel.text = [NSString stringWithFormat:@"%@元",_model.day30_money];
}
- (void)setUserInfo:(CTUserInfoModel *)userInfo{
    _userInfo = userInfo;
     _profitLabel.text = [NSString stringWithFormat:@"%@元",_userInfo.day30_money];
}

@end
