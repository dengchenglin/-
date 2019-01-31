//
//  CTWithdrawSuccessView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWithdrawSuccessView.h"

@implementation CTWithdrawSuccessView

- (IBAction)closeAction:(id)sender {
    if(self.closeBlock){
        self.closeBlock();
    }
    if(self.callback){
        self.callback(0);
    }
}


@end
