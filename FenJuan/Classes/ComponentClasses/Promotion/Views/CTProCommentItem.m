//
//  CTProCommentItem.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTProCommentItem.h"

@implementation CTProCommentItem


- (IBAction)copyAction:(id)sender {
    if(self.titleLabel.text.length){
       
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        
        pasteboard.string =  self.titleLabel.text;
        [pasteboard updateCount];
        [MBProgressHUD showMBProgressHudWithTitle:@"复制成功"];
    }
}

@end
