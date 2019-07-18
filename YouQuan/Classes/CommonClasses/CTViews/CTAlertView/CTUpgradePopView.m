//
//  CTUpgradePopView.m
//  YouQuan
//
//  Created by dengchenglin on 2019/7/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTUpgradePopView.h"

@implementation CTUpgradePopView

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [self.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.closeBlock){
            self.closeBlock();
        }
    }];
}

@end
