//
//  CTMrdkMyScoreView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkMyScoreView.h"

@implementation CTMrdkMyScoreView

- (void)setModel:(FJMrdkMyScoreFj *)model{
    _model = model;
    _enrollLabel.text = _model.enroll_money;
    _gainLabel.text = _model.gain_money;
    _morningTimesLabel.text = _model.morning_times;
}
@end
