//
//  CTPayTypeContainerView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/26.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPayTypeContainerView.h"

#import "CTPayTypeItem.h"
@interface CTPayTypeContainerView()
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *logos;
@end
@implementation CTPayTypeContainerView

ViewInstance(setUp)
- (void)setUp{
    self.titles = @[@"惠已达人可用余额",@"支付宝支付",@"微信支付"];
    self.logos = @[@"pic_punch_bonus",@"pic_punch_alipay",@"pic_punch_wechat"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadView];
    });
    self.payType = 1;
}

- (void)reloadView{
    [self removeAllSubViews];
    if(!self.width || !self.height){
        return;
    }
    CGFloat height = self.height/self.titles.count;
    UIView *topView;
    for(int i = 0;i < self.titles.count;i ++){
        CTPayTypeItem *item = NSMainBundleClass(CTPayTypeItem.class);
        if(i == 0){
            item.selected = YES;
            
        }
        item.tag = 100 + i;
        item.logoImageView.image = [UIImage imageNamed:self.logos[i]];
        item.titelLabel.text = self.titles[i];
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(topView){
                make.top.mas_equalTo(topView.mas_bottom);
            }
            else{
                make.top.mas_equalTo(0);
            }
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(height);
        }];
        topView = item;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [item addGestureRecognizer:tap];
        
    }
}


- (void)tapAction:(UITapGestureRecognizer *)tap{
    for(int i = 0;i < self.titles.count;i ++){
        CTPayTypeItem *item = [self viewWithTag:100 + i];
        item.selected = item == tap.view;
        
    }
    self.payType = tap.view.tag - 100 + 1;
}
@end
