//
//  CTWithDrawInputView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWithDrawInputView.h"
@implementation CTWithdrawTextField

- (CGRect)caretRectForPosition:(UITextPosition *)position{
    CGRect rect = [super caretRectForPosition:position];
    rect.origin.y = (rect.size.height - 40)/2;
    rect.size.height = 40;
    return rect;
}
@end

@implementation CTWithDrawInputView
- (void)awakeFromNib{
    [super awakeFromNib];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"请填写您的提现金额"];
    [string addAttributes:@{NSFontAttributeName:CTPsmFont(15)} range:NSMakeRange(0, string.length)];
    _moneyTextField.attributedPlaceholder = string;
    _moneyTextField.clearButtonMode = UITextFieldViewModeAlways;
}
- (IBAction)withdrawAll:(id)sender {
    if([CTAppManager user].money.floatValue < 0.001){
        [MBProgressHUD showMBProgressHudWithTitle:@"抱歉！您的余额不足"];
        return;
    }
    self.moneyTextField.text = [CTAppManager user].money;
    if(self.withDrawActionBlock){
        self.withDrawActionBlock();
    }
}


@end
