//
//  CTCashListCell.m
//  YouQuan
//
//  Created by dengchenglin on 2019/8/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTCashListCell.h"

@implementation CTCashListCell

- (void)setModel:(CTCashModel *)model{
    _model = model;
    _amountLabel.text = _model.money;
    _statusLabel.text = _model.status_txt;
    _accountLabel.text = _model.account_txt;
    _dateLabel.text = _model.update_time;
}

@end
