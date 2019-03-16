//
//  CTNoticeAlertView.m
//  CouponTicket
//
//  Created by Dankal on 2019/3/16.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTNoticeAlertView.h"

@implementation CTNoticeAlertView

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [self.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.closeBlock){
            self.closeBlock();
        }
        if(self.callback){
            self.callback(0);
        }
    }];
}

@end
