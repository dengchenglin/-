//
//  CTSearchTextfield.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchTextfield.h"

@implementation CTSearchTextfield

ViewInstance(setUp)

- (void)setUp{
    UIImageView *searchLogo = [[UIImageView alloc]init];
    searchLogo.image = [UIImage imageNamed:@"ic_search"];
    searchLogo.frame = CGRectMake(0, 0, 15, 15);
    self.leftView = searchLogo;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.placeholder = @"搜索宝贝名称或粘贴淘宝标题";
    self.clearButtonMode = UITextFieldViewModeAlways;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x = 15;
    return rect;
}


- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x += 8;
    return rect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x += 8;
    return rect;
}

@end
