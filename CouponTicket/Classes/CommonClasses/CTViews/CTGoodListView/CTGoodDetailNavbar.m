
//
//  CTGoodDetailNavbar.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodDetailNavbar.h"

@interface CTGoodDetailNavbar()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation CTGoodDetailNavbar
- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundAlpha = 0;
    _titleLabel.alpha = 0;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha{
    _backgroundAlpha = backgroundAlpha;
    _backgroundImageView.alpha = _backgroundAlpha;
    _titleLabel.alpha = _backgroundAlpha;
}

@end
