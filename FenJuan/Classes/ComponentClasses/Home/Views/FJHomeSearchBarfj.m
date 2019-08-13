//
//  CTHomeSearchBar.m
//  YouQuan
//
//  Created by dengchenglin on 2019/7/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHomeSearchBarfj.h"

@interface CTHomeSearchTfd:UITextField
@end

@implementation CTHomeSearchTfd



@end
@interface FJHomeSearchBarfj()<UITextFieldDelegate>
@end
@implementation FJHomeSearchBarfj

- (void)awakeFromNib{
    [super awakeFromNib];
    UIImageView *searchLogo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    searchLogo.contentMode = UIViewContentModeCenter;
    searchLogo.image = [[UIImage imageNamed:@"i_home_search"] imageWithColor:RGBColor(150, 150, 150)];
    _searchTextField.leftView = searchLogo;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:@"搜索宝贝名称或粘贴淘宝标题"];
//    [att setAttributes:@{NSForegroundColorAttributeName:HexColor(@"#666666")} range:NSMakeRange(0, att.string.length)];
//
//    _searchTextField.attributedPlaceholder = att;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(self.clickSearchBarBlock){
        self.clickSearchBarBlock();
    }
    return NO;
}


@end
