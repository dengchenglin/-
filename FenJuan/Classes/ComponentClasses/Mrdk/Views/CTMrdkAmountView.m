//
//  CTMrdkAmountView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkAmountView.h"

@implementation CTMrdkAmountView
{
    NSTimer *_timer;
}
- (void)setModel:(CTMrdkIndexModel *)model{
    _model = model;
    _amountDescLabel.text = _model.tip_txt1;
    _amountLabel.text = _model.activity.total_money;
    _countLabel.text = _model.activity.people_num;
    
    self.doneButton.userInteractionEnabled = YES;
    [self.doneButton setBackgroundImage:[UIImage imageNamed:@"ic_home_service_bot2"] forState:UIControlStateNormal];
    NSString *title;
    if(_model.activity.activity_user_status == 1){
        title = @"参与挑战";
    }
    else if (_model.activity.activity_user_status == 2){
        self.doneButton.userInteractionEnabled = NO;
        //倒计时
        if(_timer){
            [_timer invalidate];
            _timer = nil;
        }
        __block NSInteger t = _model.activity.signin_surplus_time;
        title = [NSString stringWithFormat:@"打卡倒计时:%@",[CTMrdkAmountView timerStringWithT:t]];
        __weak typeof(self) weakSelf = self;
        if(t > 0){
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
                t --;
                if(t > 0){
                    NSString *ts = [NSString stringWithFormat:@"打卡倒计时:%@",[CTMrdkAmountView timerStringWithT:t]];
                    [weakSelf.doneButton setTitle:ts forState:UIControlStateNormal];
                }
                else{
                    POST_NOTIFICATION(CTRefrehMrdkIndexNotification);
                   
                }
            } repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
        }
        else{
            POST_NOTIFICATION(CTRefrehMrdkIndexNotification);
        }
    }else if (_model.activity.activity_user_status == 3){
       
        title = @"打卡";
    }else if (_model.activity.activity_user_status == 4){
        [self.doneButton setBackgroundImage:[UIImage imageWithColor:RGBColor(200, 200, 200)] forState:UIControlStateNormal];
        title = @"等待开奖";
        self.doneButton.userInteractionEnabled = NO;
    }
    [self.doneButton setTitle:title forState:UIControlStateNormal];
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if(!newSuperview){
        if(_timer){
            [_timer invalidate];
            _timer = nil;
        }
    }
}

+ (NSString *)timerStringWithT:(NSInteger)t{
    NSInteger hour = t/3600;
    NSInteger mintue = (t%3600)/60;
    NSInteger second = t%60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hour,mintue,second];
}
@end
