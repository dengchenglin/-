//
//  CTProfitShareView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTProfitShareView.h"

@implementation CTProfitShareView

- (void)awakeFromNib{
    [super awakeFromNib];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 2;
    shadow.shadowColor = [UIColor colorWithRed:144/255.0 green:41/255.0 blue:31/255.0 alpha:0.67];
    shadow.shadowOffset =CGSizeMake(0,1);

    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"用优券APP买东西\n不仅划算" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:20],NSShadowAttributeName: shadow}];
    
    _attractiveTitleLabel.attributedText = string;
    _attractiveTitleLabel.textAlignment = NSTextAlignmentCenter;
    _attractiveTitleLabel.alpha = 1.0;
}

- (void)setUsername:(NSString *)username{
    _username = username;
    _usernameLabel.text = _username;
}
- (void)setUsericon:(NSString *)usericon{
    _usericon = usericon;
}
- (void)setUserlevel:(NSString *)userlevel{
    _userlevel = userlevel;
    _userlevelLabel.text = _userlevel;
}
- (void)setProfit:(NSString *)profit{
    _profit = profit;
    NSString *str = [NSString stringWithFormat:@"还赚了%@元",_profit];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttributes:@{NSFontAttributeName:CTPsbFont(45)} range:[str rangeOfString:_profit]];
    _attractiveProfitLabel.attributedText = string;
}
- (void)setBalance:(NSString *)balance{
    _balance = balance;
    NSString *str = [NSString stringWithFormat:@"还有%@元即将到账",_balance];
    _attractiveBalanceLabel.text = str;
}

- (void)setQrCode:(NSString *)qrCode{
    _qrCode = qrCode;
    _qrCodeLabel.text = [NSString stringWithFormat:@"邀请码 %@",_qrCode];
}

@end
