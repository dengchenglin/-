//
//  CTHotSalesNoticeView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHotSalesNoticeView.h"

NSString * GetDifferTimeStrWithNextUpdateTimestamp(NSTimeInterval nextUpdateTimestamp){
    NSTimeInterval nowTimestamp = [DateUtil getNowDateTimestamp].doubleValue;
    if(nextUpdateTimestamp > nowTimestamp){
        NSInteger subTime = nextUpdateTimestamp - nowTimestamp;
        NSInteger hour = subTime/3600;
        NSInteger mintue = (subTime%3600)/60;
        NSInteger second = subTime%60;
        NSMutableString *string = [NSMutableString string];
        if(hour){
            [string appendFormat:@"%zu时",hour];
        }
        if(mintue){
            [string appendFormat:@"%zu分",mintue];
        }
        if(second){
            [string appendFormat:@"%zu秒",second];
        }
        return string;
    }
    return nil;
}

@implementation CTHotSalesNoticeView
{
    NSTimer *_timer;
}
- (void)setModel:(CTHotGoodsModel *)model{
    _model = model;
    if(_timer && [_timer isValid]){
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
        NSString *differStr = GetDifferTimeStrWithNextUpdateTimestamp(_model.next_update_timestamp);
        if(differStr){
             _titleLabel.text = [NSString stringWithFormat:@"%@,%@后更新",_model.update_text,differStr];
        }
        else{
            _titleLabel.text = _model.update_text;
            [timer invalidate];
            timer = nil;
            POST_NOTIFICATION(CTRefreshHotGoodsNotification);
            POST_NOTIFICATION(CTRefreshHomeNotification);
        }
       
    } repeats:YES];
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if(!newSuperview){
        if(_timer && _timer.isValid){
            [_timer invalidate];
            _timer = nil;
        }
    }
}
@end
