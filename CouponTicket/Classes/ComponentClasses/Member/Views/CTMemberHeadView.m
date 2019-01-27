//
//  CTMemberHeadView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMemberHeadView.h"

#import "CALayer+YYAdd.h"

@interface CTMemberHeadView()


@end

@implementation CTMemberHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(254,64.5,94.5,24);
    gl.startPoint = CGPointMake(0, 0.5);
    gl.endPoint = CGPointMake(1, 0.5);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:231/255.0 green:208/255.0 blue:153/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:245/255.0 green:211/255.0 blue:130/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:209/255.0 green:180/255.0 blue:110/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(0.5f), @(1.0f)];
    _equityBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[gl snapshotImage]];
}

@end
