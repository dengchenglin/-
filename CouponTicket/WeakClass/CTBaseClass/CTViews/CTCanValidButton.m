//
//  CTCanValidButton.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTCanValidButton.h"

@implementation CTCanValidButton

ViewInstance(setUp)

- (void)setUp{
    self.backgroundColor = CTEnterButtonColor;
    self.layer.cornerRadius = 4;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [[self rac_valuesForKeyPath:@"enabled" observer:self] subscribeNext:^(id x) {
        BOOL enabled = [x boolValue];
        self.backgroundColor = enabled ?CTEnterButtonColor : CTLightGrayColor;
        UIColor *textColor = enabled?[UIColor whiteColor]:RGBColor(153, 153, 153);
        [self setTitleColor:textColor forState:UIControlStateNormal];
    }];
}


@end
