//
//  CTMessageListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJMessageListCellfj.h"

@implementation FJMessageListCellfj

- (void)setModel:(CTMessageModel *)model{
    _model = model;
    _titleLabel.text = _model.title;
    _descLabel.text = _model.intro;
    _dateLabel.text = _model.fb_time;
}

@end
