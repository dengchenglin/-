//
//  CTMemberStrategyItem.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "FJMemberStrategyItemfj.h"

@implementation FJMemberStrategyItemfj

- (void)awakeFromNib{
    [super awakeFromNib];
    
}


- (void)setTitle:(NSString *)title{
    _title = title;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:_title];
    
    [string addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineColorAttributeName:RGBColor(255, 97, 36)} range:NSMakeRange(0, string.length)];
    self.titleLabel.attributedText = string;
}
@end
