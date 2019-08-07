//
//  CTPayTypeItem.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/26.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPayTypeItem.h"

@implementation CTPayTypeItem

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    self.selectedImageView.hidden = !_selected;
}

@end
