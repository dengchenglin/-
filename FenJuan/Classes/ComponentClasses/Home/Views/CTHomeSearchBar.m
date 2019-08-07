//
//  CTHomeSearchBar.m
//  YouQuan
//
//  Created by dengchenglin on 2019/7/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeSearchBar.h"

@interface CTHomeSearchTfd:UITextField
@end

@implementation CTHomeSearchTfd



@end
@interface CTHomeSearchBar()<UITextFieldDelegate>
@end
@implementation CTHomeSearchBar

- (void)awakeFromNib{
    [super awakeFromNib];
    UIImageView *searchLogo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    searchLogo.contentMode = UIViewContentModeCenter;
    searchLogo.image = [UIImage imageNamed:@"ic_home_search"];
    _searchTextField.leftView = searchLogo;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:@"搜索宝贝名称或粘贴淘宝标题"];
    [att setAttributes:@{NSForegroundColorAttributeName:HexColor(@"#FFFFFF")} range:NSMakeRange(0, att.string.length)];
    
    _searchTextField.attributedPlaceholder = att;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(self.clickSearchBarBlock){
        self.clickSearchBarBlock();
    }
    return NO;
}


@end
