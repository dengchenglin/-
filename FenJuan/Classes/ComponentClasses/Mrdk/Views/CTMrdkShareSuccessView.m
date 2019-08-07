//
//  CTMrdkShareSuccessView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkShareSuccessView.h"

@implementation CTMrdkShareSuccessView

- (IBAction)closeAction:(id)sender {
    if(self.closeBlock){
        self.closeBlock();
    }
}


@end
