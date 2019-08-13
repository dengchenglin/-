//
//  CTMineEarnView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJMineEarnViewfj.h"

@implementation FJMineEarnViewfj

- (void)awakeFromNib{
    [super awakeFromNib];
    self.earnButton.hidden = !([CTAppManager sharedInstance].showMember && [CTAppManager sharedInstance].showRanking);
    self.layer.cornerRadius = 10;
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,8);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 17.5;
    
    _earnButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    _earnButton.layer.backgroundColor = [UIColor colorWithRed:80/255.0 green:61/255.0 blue:204/255.0 alpha:1.0].CGColor;
    _earnButton.layer.cornerRadius = 2.5;
    _earnButton.layer.shadowColor = [UIColor colorWithRed:105/255.0 green:74/255.0 blue:226/255.0 alpha:0.4].CGColor;
    _earnButton.layer.shadowOffset = CGSizeMake(0,5);
    _earnButton.layer.shadowOpacity = 1;
    _earnButton.layer.shadowRadius = 6.5;
    
}
- (void)setModel:(CTMyEarnModel *)model{
    _model = model;

    self.earnButton.hidden = !([CTAppManager sharedInstance].showMember && [CTAppManager sharedInstance].showRanking);
    _totalRebateLabel.text = [@"¥" stringByAppendingString:_model.all_money?:@""];
    _priceLabel1.text = [@"¥" stringByAppendingString:_model.today_money?:@""];
    _priceLabel2.text = [@"¥" stringByAppendingString:_model.month_money?:@""];
    _priceLabel3.text = [@"¥" stringByAppendingString:_model.lm_money?:@""];
    _priceLabel4.text = [@"¥" stringByAppendingString:_model.sl_today_money?:@""];
    _priceLabel5.text = [@"¥" stringByAppendingString:_model.sl_month_money?:@""];
    _priceLabel6.text = [@"¥" stringByAppendingString:_model.sl_lm_money?:@""];
    
}

@end
