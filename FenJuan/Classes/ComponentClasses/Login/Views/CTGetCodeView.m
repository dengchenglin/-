//
//  CTGetCodeView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGetCodeView.h"

@implementation CTGetCodeView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.getCodeButton.timeInterval = 60;
}

@end
