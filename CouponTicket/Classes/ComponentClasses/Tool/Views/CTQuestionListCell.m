//
//  CTQuestionListCell.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/30.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTQuestionListCell.h"

@implementation CTQuestionListCell
- (void)setModel:(CTQuestionModel *)model{
    _model = model;
    _titleLabel.text = [@"Q. " stringByAppendingString:_model.name];
}

@end
