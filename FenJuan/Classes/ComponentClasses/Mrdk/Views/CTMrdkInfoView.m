//
//  CTMrdkInfoView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkInfoView.h"

@implementation CTMrdkInfoView

- (void)setModel:(FJMrdkIndexModel_fj *)model{
    _model = model;
    _countLabel.text = _model.my_score.morning_times;
    _amountLabel.text = _model.my_score.gain_money;
    
    [_zzaoIcon sd_setImageWithURL:[NSURL URLWithString:_model.today_activity_record.user1.headimg]];
    _zzaoNameLabel.text = _model.today_activity_record.user1.name;
    _zzaoDescLabel.text = _model.today_activity_record.user1.txt;
    
    [_zjiaIcon sd_setImageWithURL:[NSURL URLWithString:_model.today_activity_record.user2.headimg]];
    _zjiaNameLabel.text = _model.today_activity_record.user2.name;
    _zjiaDescLabel.text = _model.today_activity_record.user2.txt;
    
    [_zjiuIcon sd_setImageWithURL:[NSURL URLWithString:_model.today_activity_record.user3.headimg]];
    _zjiuNameLabel.text = _model.today_activity_record.user3.name;
    _zjiuDescLabel.text = _model.today_activity_record.user3.txt;
    
}
@end
