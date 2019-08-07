//
//  CTSearchTikcetPasteView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchTikcetPasteView.h"

#import "UIPasteboard+Helper.h"

#import "UITextView+ZWPlaceHolder.h"

@interface CTSearchTikcetPasteView()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *pasteLabel;
@property (weak, nonatomic) IBOutlet CTButton *searchButton;
@property (weak, nonatomic) IBOutlet UIView *contentBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *pasteTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pasteTextHeight;
@property (weak, nonatomic) IBOutlet UIView *pasteActionView;

@end

@implementation CTSearchTikcetPasteView

- (void)awakeFromNib{
    [super awakeFromNib];
    _contentBackgroundView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    _contentBackgroundView.layer.cornerRadius = 2.5;
    _contentBackgroundView.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:38/255.0 alpha:0.4].CGColor;
    _contentBackgroundView.layer.shadowOffset = CGSizeMake(0,7);
    _contentBackgroundView.layer.shadowOpacity = 1;
    _contentBackgroundView.layer.shadowRadius = 22;
    
    _textView.placeholder = @"请输入宝贝名称或粘贴淘宝标题";
    
    self.text = [UIPasteboard generalPasteboard]._newestString;
    
    [_navBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(115 + NAVBAR_TOP);
    }];
    
    @weakify(self)
    [_pasteActionView addActionWithBlock:^(id target) {
        @strongify(self);
        [self paste];
    }];
    [_searchButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.textView.text.length){
             [self paste];
        }
        if(self.searchBlock && self.textView.text.wipSpace.length){
            self.searchBlock(self.textView.text);
        }
    }];
}

- (void)setText:(NSString *)text{
    _text = text;
    if(_text.length){
        _pasteTextHeight.constant = 60;
    }
    else{
        _pasteTextHeight.constant = 0;
    }
    _pasteLabel.text = _text;
    [self layoutIfNeeded];
}

- (void)paste{
    if(self.pasteLabel.text.length){
        self.textView.text = self.pasteLabel.text;
        self.text = nil;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        if(self.textView.text.length){
            if(self.searchBlock){
                self.searchBlock(self.textView.text);
            }
        }
        return NO;
    }
    return YES;
}


@end
