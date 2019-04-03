//
//  CTEarnTrendCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTEarnTrendCell.h"

@implementation CTEarnTrendCell

- (void)setModel:(CTEarnIndexModel *)model{
    _model = model;
    _dateLabel.text = _model.date;
    _profitLabel.text = [NSString stringWithFormat:@"¥%@",_model.money];
    _contributionLabel.text = [NSString stringWithFormat:@"¥%@",_model.branch_money];
    _countLabel.text = _model.order_num;
}

@end
