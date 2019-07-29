//
//  CTSearchTextfield.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchTextfield.h"
@interface CTSearchTextfield()<UITextFieldDelegate>
@end

@implementation CTSearchTextfield
{
    UIImageView *_searchLogo;
    
}

ViewInstance(setUp)

- (void)setUp{
    self.delegate = self;
    self.returnKeyType = UIReturnKeySearch;
    _searchLogo = [[UIImageView alloc]init];
    _searchLogo.image = [UIImage imageNamed:@"ic_search"];
    _searchLogo.frame = CGRectMake(0, 0, 15, 15);
    self.leftView = _searchLogo;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.placeholder = @"搜索宝贝名称或粘贴淘宝标题";
    self.clearButtonMode = UITextFieldViewModeAlways;
}
- (void)setLogoColor:(UIColor *)logoColor{
    _logoColor = logoColor;
    _searchLogo.image = [[UIImage imageNamed:@"ic_search"] imageWithColor:_logoColor];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x = 15;
    return rect;
}


- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x += 8;
    rect.size.width -= 10;
    return rect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x += 8;
    return rect;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(self.searchBlock && textField.text.wipSpace.length){
        self.searchBlock(textField.text);
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(self.clickSeachBlock){
        self.clickSeachBlock();
        return NO;
    }
    return YES;
}

@end
