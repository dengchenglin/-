//
//  CTEarnDescView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJEarnDescViewfj.h"

@implementation FJEarnDescViewfj

- (void)setModel:(CTMyEarnModel *)model{
    _model = model;
    _balanceLabel.text = [CTAppManager user].money;
    _lastMonthProfitLabel.text = [NSString stringWithFormat:@"¥%@",_model.lm_all_money];
    _totalProfitLabel.text = [NSString stringWithFormat:@"¥%@",_model.all_money];
}

@end
