//
//  CLPayPasswordView.m
//  LightMaster
//
//  Created by dengchenglin on 2018/12/21.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLPayPasswordView.h"

#import "Masonry.h"

@interface CLPayPasswordMask :UIView

@property (nonatomic, assign) CGFloat maxCount;

@property (nonatomic, assign) CGFloat count;

@end

@implementation CLPayPasswordMask

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _maxCount = CLPayPasswordMaxCount;
    }
    return self;
}

- (void)setCount:(CGFloat)count{
    _count = count;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRed:207/255.0 green:215/255.0 blue:225/255.0 alpha:1.0] setStroke];
    CGContextSetLineWidth(context, 1);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
    
    CGFloat width = rect.size.width/6;
    for(int i = 1;i < _maxCount;i ++){
        CGContextMoveToPoint(context, i * width, 0);
        CGContextAddLineToPoint(context, i * width, rect.size.height);
        CGContextStrokePath(context);
    }
    for(int i = 0;i < _count;i ++){
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(i * width + width/2, rect.size.height/2) radius:5 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [[UIColor blackColor] setFill];
        [path fill];
    }
}

@end

@interface CLPayPasswordView()<UITextFieldDelegate>

@property (nonatomic, strong) CLPayPasswordMask *mask;

@end

@implementation CLPayPasswordView
{
    NSString *_lastValue;
}
ViewInstance(setUp)

- (void)setUp{
    _maxCount = CLPayPasswordMaxCount;
    _mask = [[CLPayPasswordMask alloc]init];
    [self addSubview:_mask];
    _textField = [[UITextField alloc]init];
    _textField.tintColor = [UIColor clearColor];
    _textField.textColor = [UIColor clearColor];
    _textField.delegate = self;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_textField];
  
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [_mask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    @weakify(self)
    [_textField.rac_newTextChannel subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        if(![self->_lastValue isEqualToString:self.textField.text]){
            [self reloadMask];
        }
      
    }];
}

- (void)setMaxCount:(CGFloat)maxCount{
    _maxCount = maxCount;
    _mask.maxCount = _maxCount;
}

- (void)setCount:(CGFloat)count{
    _count = count;
    _mask.count = _count;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.length == 1 && string.length == 0) {
   
        return YES;
    }
    else if (textField.text.length >= _maxCount) {
      
        return NO;
    }

    return YES;
}

- (void)reloadMask{
    self.count = _textField.text.length;
    self->_lastValue = self.textField.text;
    if(self.count == self.maxCount){
        
        if(self.passwordCallback){
            self.passwordCallback(_textField.text);
            self.passwordCallback = nil;
        }
      
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

@end
