//
//  CTSearchBar.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchBar.h"

@interface CTSearchBar()<UITextFieldDelegate>

@end

@implementation CTSearchBar

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [self.searchBtn touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.searchBlock){
            self.searchBlock(self.searchTfd.text.wipSpace);
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(self.searchBlock){
        self.searchBlock(textField.text.wipSpace);
    }
    return YES;
}

@end
