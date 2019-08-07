//
//  CTMrdkMoneyContainerView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkMoneyContainerView.h"
#import "CTMrdkMoneyItem.h"
@interface CTMrdkMoneyContainerView()
@end
@implementation CTMrdkMoneyContainerView

ViewInstance(setUp)

- (void)setUp{

 
}
- (void)setCate:(NSArray<CTMrdkMoneyCate *> *)cate{
    _cate = cate;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadView];
    });
}
- (void)reloadView{
    [self removeAllSubViews];
    if(!self.width || !self.height){
        return;
    }
    NSInteger row = 2;
    NSInteger line = (self.cate.count + row - 1)/row;
    CGFloat space = 14;
    CGFloat width = (self.width - (row - 1) * space)/row;
    CGFloat height = (self.height - (line - 1) * space)/line;
    
    UIView *leftView;
    UIView *topView;
    for(int i = 0;i < self.cate.count;i ++){
        CTMrdkMoneyItem *item = NSMainBundleClass(CTMrdkMoneyItem.class);
        if(i == 0){
            item.selected = YES;
        }
        item.amountLabel.text = self.cate[i].money;
        item.titleLabel.text = self.cate[i].txt;
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(leftView){
                make.left.mas_equalTo(leftView.mas_right).offset(space);
            }
            else{
                make.left.mas_equalTo(0);
                
            }
            if(topView){
                make.top.mas_equalTo(topView.mas_bottom).offset(space);
            }
            else{
                make.top.mas_equalTo(0);
            }
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        leftView = item;
        if((i + 1)%row == 0){
            leftView = nil;
            topView = item;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagAction:)];
        [item addGestureRecognizer:tap];
    }
}

- (void)tagAction:(UITapGestureRecognizer *)tap{
    for(CTMrdkMoneyItem *item in self.subviews){
        if(item == tap.view){
            item.selected = YES;
        }
        else{
            item.selected = NO;
        }
    }
}

- (NSString *)amount{
    __block NSString *_amount = 0;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof CTMrdkMoneyItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.selected){
            *stop = YES;
            _amount = obj.amountLabel.text;
        }
    }];
    return _amount;
}

@end
