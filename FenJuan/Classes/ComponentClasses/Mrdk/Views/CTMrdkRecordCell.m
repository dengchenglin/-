//
//  CTMrdkRecordCell.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkRecordCell.h"

@implementation CTMrdkRecordCell

- (void)setModel:(FJMrdkRecordModelfj *)model{
    _model = model;
    
    NSString *enroll_money = _model.enroll_money;
    NSString *gain_money = _model.gain_money;
    NSString *str = [NSString stringWithFormat:@"投入%@元,奖金%@元",enroll_money,gain_money];
    NSMutableAttributedString *phraseString = [[NSMutableAttributedString alloc]initWithString:str];
    [phraseString addAttributes:@{NSForegroundColorAttributeName:RGBColor(230, 65, 65)} range:[str rangeOfString:gain_money]];
    _titleLabel.attributedText = phraseString;
    _dateLabel.text = _model.create_at;
    
}

@end
