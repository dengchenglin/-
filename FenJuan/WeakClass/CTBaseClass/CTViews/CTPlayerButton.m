//
//  CTPlayerButton.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPlayerButton.h"

@implementation CTPlayerButton

ViewInstance(setUp)

- (void)setUp{
    self.selected = NO;
    [self setImage:[UIImage imageNamed:@"ic_video_play"] forState:UIControlStateNormal];
    [self setImage:[UIImage new] forState:UIControlStateSelected];
    @weakify(self)
    [RACObserve(self, selected) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.backgroundColor = [x boolValue]?[UIColor clearColor]:RGBAColor(20, 20, 20, 0.6);
    }];
}

@end
