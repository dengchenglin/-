//
//  CTMrdkShareView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkShareView.h"

#import "UIView+YYAdd.h"

@implementation CTMrdkShareView

- (void)setModel:(CTMrdkIndexModel *)model{
    _model = model;
    _titleLabel.text = _model.tip_txt1;
    _amountLabel.text = _model.activity.total_money;
    _acountLabel.text = _model.activity.people_num;
    
  
    NSString *day = _model.my_score.morning_times?:@"";
    NSString *amount = _model.my_score.gain_money?:@"";
    NSString *str = [NSString stringWithFormat:@"我已累计打卡%@天,获得了%@元奖金",day,amount];
    NSMutableAttributedString *phraseString = [[NSMutableAttributedString alloc]initWithString:str];
    [phraseString addAttributes:@{NSForegroundColorAttributeName:RGBColor(230, 65, 65)} range:[str rangeOfString:amount]];
    _phraseLabel.attributedText = phraseString;
}

+ (void)createImageWithModel:(CTMrdkIndexModel *)model completed:(void(^)(UIImage *image))completed{
    CTMrdkShareView *shareView = NSMainBundleClass(CTMrdkShareView.class);
    shareView.model = model;
    UIView *containerView = [UIView new];
    [containerView insertSubview:shareView atIndex:0];
    
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo((SCREEN_WIDTH - 50) * 1.23 + 85);
    }];
    [containerView layoutIfNeeded];
    UIImage *viewImage = [shareView snapshotImage];
    if(completed){
        completed(viewImage?:[UIImage new]);
    }
}
@end
