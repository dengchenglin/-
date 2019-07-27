//
//  CTInviteCodeView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTInviteCodeView.h"

@implementation CTInviteCodeView
- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [_cpyButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.ivCode.length){
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            
            pasteboard.string =  self.ivCode;
            [pasteboard updateCount];
            [MBProgressHUD showMBProgressHudWithTitle:@"复制成功"];
        }
        else{
              [MBProgressHUD showMBProgressHudWithTitle:@"复制失败"];
        }
    }];
}
- (void)setIvCode:(NSString *)ivCode{
    _ivCode = ivCode;
    _ivcodeLabel.text = [NSString stringWithFormat:@"%@",_ivCode];
}
@end
