//
//  CTHomeSalesView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeSalesView.h"

#import "CTSalesItem.h"

@implementation CTHomeSalesView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self reloadView];
}

- (void)reloadView{
    UIView *leftView;
    for(int i = 0;i < 3;i ++){
        CTSalesItem *item = NSMainBundleClass(CTSalesItem.class);
        item.tag = 100 + i;
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(leftView){
                make.left.mas_equalTo(leftView.mas_right);
                make.width.mas_equalTo(leftView.mas_width);
            }
            else{
                make.left.mas_equalTo(0);
            }
            if(i == 2){
                make.right.mas_equalTo(0);
            }
            make.top.mas_equalTo(self.titleheadView.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        leftView = item;
        
        @weakify(self)
        [item addActionWithBlock:^(UIView *target) {
            @strongify(self)
            if(self.clickItemBlock){
                self.clickItemBlock(target.tag - 100);
            }
        }];
    }
}

@end
