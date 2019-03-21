//
//  CTHomeSalesView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeSalesView.h"

#import "CTSalesItem.h"

@implementation CTHomeSalesView
{
    NSTimer *_timer;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self reloadView];
}

- (void)reloadView{
    UIView *leftView;
    NSInteger count = 3;
    for(int i = 0;i < count;i ++){
        CTSalesItem *item = NSMainBundleClass(CTSalesItem.class);
        item.tag = 100 + i;
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(leftView){
                make.left.mas_equalTo(leftView.mas_right);
                make.width.mas_equalTo(leftView.mas_width);
            }
            else{
                make.left.mas_equalTo(0);
            }
            if(i == 2){
                make.right.mas_equalTo(0);
            }
            make.top.mas_equalTo(self.titleheadView.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        leftView = item;
        
        @weakify(self)
        [item addActionWithBlock:^(UIView *target) {
            @strongify(self)
            if(self.clickItemBlock){
                self.clickItemBlock(target.tag - 100);
            }
        }];
    }
}

- (void)setModel:(CTHomeHotGoodsModel *)model{
    _model = model;
    for(int i = 0;i < 3;i ++){
        CTSalesItem *item = [self viewWithTag:100 + i];
        item.model = [_model.goods safe_objectAtIndex:i];
        item.hidden = !item.model;
    }
    if(_timer && _timer.isValid){
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
        _model.next_update_timestamp -= 1;
        NSString *displayText = GetdifferTimeStrWithNextUpdateTimestamp(_model.next_update_timestamp);
        if(displayText.length){
            _timeLabel.text = [NSString stringWithFormat:@"%@后更新",GetdifferTimeStrWithNextUpdateTimestamp(_model.next_update_timestamp)];
        }
        else{
            _timeLabel.text = @"最新";
            [timer invalidate];
            timer = nil;
        }
     
    } repeats:YES];
}

NSString * GetdifferTimeStrWithNextUpdateTimestamp(NSTimeInterval nextUpdateTimestamp){
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
