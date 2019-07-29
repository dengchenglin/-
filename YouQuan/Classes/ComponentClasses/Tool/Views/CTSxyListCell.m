//
//  CTSxyListCell.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSxyListCell.h"

@implementation CTSxyListCell

- (void)setModel:(CTSxyModel *)model{
    _model = model;
    _titleLabel.text = _model.title;
    _contentLabel.text = _model.describe;
}

@end
