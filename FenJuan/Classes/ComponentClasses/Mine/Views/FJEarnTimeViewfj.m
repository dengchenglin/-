//
//  CTEarnTimeView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJEarnTimeViewfj.h"

@implementation FJEarnTimeViewfj

- (void)setInfo:(CTEarnInfo *)info{
    _info = info;
    _profitLabel.text = [NSString stringWithFormat:@"¥%@",_info.money];
    _countLabel.text = _info.order_num;
}

@end
