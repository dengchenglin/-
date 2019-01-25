//
//  CLRefreshCurveLayer.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/3.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshCurveLayer.h"

#import <UIKit/UIKit.h>

@implementation CLRefreshCurveLayer


- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}
-(void)drawInContext:(CGContextRef)ctx{
    
    [super drawInContext:ctx];
    
    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Draw
    CGFloat radius = self.bounds.size.width/2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - 3 startAngle:- M_PI_4 endAngle:-M_PI_4 + (2 * M_PI - M_PI/8)* _progress clockwise:YES];
    path.lineWidth = 1.5;
    [[UIColor colorWithRed:255/255.0f green:97/255.0f blue:36/255.0f alpha:1] setStroke];
    CGContextSetLineCap(context, kCGLineCapRound);

    [path stroke];
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    
    [[UIColor blackColor] setStroke];
    UIGraphicsPopContext();
    
}




@end
