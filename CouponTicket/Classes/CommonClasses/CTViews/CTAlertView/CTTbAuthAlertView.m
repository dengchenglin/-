//
//  CTTbAuthAlertView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTTbAuthAlertView.h"

@interface CTTbAuthAlertView()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end
@implementation CTTbAuthAlertView

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [self.closeButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.callback){
            self.callback(0);
        }
    }];
    [self.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.callback){
            self.callback(1);
        }
    }];
}

@end
