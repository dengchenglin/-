//
//  CLTextField.m
//  LightMaster
//
//  Created by Dankal on 2018/12/30.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import "CLTextField.h"

@implementation CLTextField

ViewInstance(setUp)self.passwordView.passwordTfd.keyboardType = UIKeyboardTypeNumberPad;
self.passwordView.repasswordTfd.maxCount = 6;

- (void)setUp{
    _maxCount = 32;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cl_textFiledEditChanged) name:@"UITextFieldTextDidChangeNotification" object:nil];
}

- (void)cl_textFiledEditChanged{
    NSString *toBeString = self.text;
    NSString *lang = [self.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *highlightRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:highlightRange.start offset:0];
        
   
       NSInteger  positionLengh =  [self offsetFromPosition:highlightRange.start toPosition:highlightRange.end];
      
        NSString *selectedText = [self.text substringWithRange:NSMakeRange(0, self.text.length - positionLengh)];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > self.maxCount)
            {
                //判断第三方中文输入法的emoji表情
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxCount];
                if (rangeIndex.length == 1)
                {
                    self.text = [toBeString substringToIndex:self.maxCount];
                    selectedText = self.text;
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxCount)];
                    self.text = [toBeString substringWithRange:rangeRange];
                    selectedText = self.text;
                }
                if(self.editingBlock){
                    self.editingBlock(YES, selectedText);
                }
            }
            else{
                if(self.editingBlock){
                    self.editingBlock(NO, selectedText);
                }
            }
        }
       
       
    }
    
    // 中文输入法以外（英文和emoji）的直接对其统计限制即可
    else
    {
        if (toBeString.length > self.maxCount)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxCount];
            if (rangeIndex.length == 1)
            {
                self.text = [toBeString substringToIndex:self.maxCount];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxCount)];
                self.text = [toBeString substringWithRange:rangeRange];
            }
            if(self.editingBlock){
                self.editingBlock(YES,self.text);
            }
        }
        else{
            if(self.editingBlock){
                self.editingBlock(NO,self.text);
            }
        }
        
    }
    
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
