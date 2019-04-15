//
//  CTButton.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTButton.h"

#import "CALayer+YYAdd.h"

@implementation CTButton

ViewInstance(setUp)

- (void)setUp{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(27.5,258.5,318.5,46);
    gl.startPoint = CGPointMake(0, 0.5);
    gl.endPoint = CGPointMake(1, 0.5);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:115/255.0 blue:38/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [self setBackgroundImage:[gl snapshotImage] forState:UIControlStateNormal];
}

@end
