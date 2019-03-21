//
//  CTHomeSpreeShopView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeSpreeShopView.h"

#import "CTSpreeShopItem.h"

@implementation CTHomeSpreeShopView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self reloadView];
}

- (void)reloadView{
    NSInteger count = 6;
    UIView *leftView;
    UIView *topView = self.headView;
    for(int i = 0;i < count;i ++){
        CTSpreeShopItem *item = NSMainBundleClass(CTSpreeShopItem.class);
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
            if((i + 1)%3 == 0){
                make.right.mas_equalTo(0);
            }
            make.top.mas_equalTo(topView.mas_bottom);
            make.height.mas_equalTo(230);
        }];
        
        leftView = item;
        if((i + 1)%3 == 0){
            topView = item;
            leftView = nil;
        }
        @weakify(self)
        [item addActionWithBlock:^(UIView *target) {
            @strongify(self)
            if(self.clickItemBlock){
                self.clickItemBlock(target.tag - 100);
            }
        }];
    }
}

- (void)setModel:(CTHomeCurTimeBuyModel *)model{
    _model = model;
    _currentTimeLabel.text = _model.time;
    _nextTimeLabel.text = _model.next_time;
    for(int i = 0;i < 6;i ++){
        CTSpreeShopItem *item = [self viewWithTag:100 + i];
        item.model = [_model.goods safe_objectAtIndex:i];
        item.hidden = !item.model;
    }
}

@end
