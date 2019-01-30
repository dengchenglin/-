//
//  CTContentInputView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTContentInputView.h"

#import "UITextView+ZWPlaceHolder.h"

@interface CTContentInputView()<UITextViewDelegate>

@end

@implementation CTContentInputView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.textView.placeholder = @"* 我们懂得倾听，请写下您的建议";
    _maxCount = 200;
}

- (void)setMaxCount:(NSUInteger)maxCount{
    _maxCount = maxCount;
    _maxCountLabel.text = [NSString stringWithFormat:@"/%lu",_maxCount];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.length == 1 && text.length == 0) {
        self.countLabel.text = [NSString stringWithFormat:@"%lu",textView.text.length];
        return YES;
    }
    else if (textView.text.length >= self.maxCount) {
        NSString *str = [NSString stringWithFormat:@"您最多只能输入%lu个字符",self.maxCount];
        [MBProgressHUD showMBProgressHudWithTitle:str hideAfterDelay:1.0];
        textView.text = [textView.text substringToIndex:self.maxCount];
        self.countLabel.text = [NSString stringWithFormat:@"%lu",textView.text.length];
        return NO;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%lu",textView.text.length];
    return YES;
}

@end
