//
//  CTEarnRankNavBar.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJEarnRankNavBarfj.h"

@implementation FJEarnRankNavBarfj

- (void)awakeFromNib{
    [super awakeFromNib];

    [self.backButton setImage:[[UIImage imageNamed:@"i_return"] imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = _title;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha{
    _backgroundAlpha = backgroundAlpha;
    self.backgroundColor = RGBAColor(80, 61, 204, _backgroundAlpha);
    self.titleLabel.alpha = _backgroundAlpha;
}

@end
