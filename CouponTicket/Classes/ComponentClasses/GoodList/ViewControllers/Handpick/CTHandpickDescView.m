//
//  CTHandpickDescView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHandpickDescView.h"

@implementation CTHandpickDescView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 33;
}

@end
