//
//  CTGoodIndexVerticalCell.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodIndexVerticalCell.h"

@implementation CTGoodIndexVerticalCell
- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.layer.borderWidth = LINE_WIDTH;
    self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#EFEFEF"].CGColor;
     
}
@end
