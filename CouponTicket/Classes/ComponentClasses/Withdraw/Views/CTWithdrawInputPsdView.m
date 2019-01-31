//
//  CTWithdrawInputPsdView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWithdrawInputPsdView.h"

#import "CLPayPasswordView.h"

@interface CTWithdrawInputPsdView()

@property (weak, nonatomic) IBOutlet CLPayPasswordView *passwordInputView;

@end

@implementation CTWithdrawInputPsdView

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [_passwordInputView setPasswordCallback:^(NSString *password) {
        @strongify(self)
        if(self.callback){
            self.callback(password);
            self.callback = nil;
        }
    }];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.passwordInputView.textField becomeFirstResponder];
    });
}
- (IBAction)closeAction:(id)sender {
    if(self.closeBlock){
        self.closeBlock();
    }
}

- (void)keyWillShow:(NSNotification *)note
{
    
    CGRect keyBoardRect = [[[note userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect rect = [self.superview convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
    if(keyBoardRect.origin.y < CGRectGetMaxY(rect)){
        CGFloat offest = CGRectGetMaxY(rect) - keyBoardRect.origin.y;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.superview.mas_centerY).offset(-offest);
        }];
        [self.superview layoutIfNeeded];
    }
    
}
// 键盘即将下落调用
- (void)keyWillHidden:(NSNotification *)note
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.superview.mas_centerY);
    }];
    [self.superview layoutIfNeeded];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
