//
//  TimerButton.m
//  YMKMain
//
//  Created by dengchenglin on 2018/7/2.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "CLTimerButton.h"

#import "NSTimer+YYAdd.h"

@implementation CLTimerButton
{
    NSTimer *_timer;
}


- (void)startTimer{
    self.enabled = NO;
    __block NSTimeInterval tempInterval =  _timeInterval;
    [self setTitle:[NSString stringWithFormat:@"%.0fS",tempInterval] forState:UIControlStateDisabled];
    @weakify(self)
    if(!_timer && tempInterval >= 0){
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
            @strongify(self)
            tempInterval --;
            [self setTitle:[NSString stringWithFormat:@"%.0fS",tempInterval] forState:UIControlStateDisabled];
            if(tempInterval <= 1){
                self.enabled = YES;
                if([timer isValid]){
                    [timer invalidate];
                    self->_timer = nil;
                }
                
            }
        } repeats:YES];
    }
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if(!newSuperview){
        if([_timer isValid]){
            [_timer invalidate];
            _timer = nil;
        }
    }
}

@end
