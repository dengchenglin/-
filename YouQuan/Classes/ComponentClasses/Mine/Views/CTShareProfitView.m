//
//  CTShareProfitView.m
//  YouQuan
//
//  Created by dengchenglin on 2019/7/29.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTShareProfitView.h"
#import "UIView+YYAdd.h"
@implementation CTShareProfitView

- (void)awakeFromNib{
    [super awakeFromNib];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 2;
    shadow.shadowColor = [UIColor colorWithRed:144/255.0 green:41/255.0 blue:31/255.0 alpha:0.67];
    shadow.shadowOffset =CGSizeMake(0,1);
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"用优券APP买东西\n简直太划算啦" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:20],NSShadowAttributeName: shadow}];
    
    _attractiveTitleLabel.attributedText = string;
    _attractiveTitleLabel.textAlignment = NSTextAlignmentCenter;
    _attractiveTitleLabel.alpha = 1.0;
}
+ (void)createImagesWithBackgroundImgs:(NSArray <NSString *>*)backgroundImgs ivCodeImg:(NSString *)ivCodeImg ivCode:(NSString *)ivCode user:(CTUser *)user completed:(void(^)(NSArray <UIImage *>*images))completed{
    NSMutableArray *array = [NSMutableArray array];
    for(NSString *backgroundImg in backgroundImgs){
        [self createImageWithBackgroundImg:backgroundImg ivCodeImg:ivCodeImg ivCode:ivCode user:user completed:^(UIImage *image) {
            [array addObject:image];
            if(array.count == backgroundImgs.count){
                if(completed){
                    completed(array);
                }
            }
        }];
    }
}

+ (void)createImageWithBackgroundImg:(NSString *)backgroundImg ivCodeImg:(NSString *)ivCodeImg ivCode:(NSString *)ivCode user:(CTUser *)user completed:(void(^)(UIImage *image))completed{
    CTShareProfitView *imgView = NSMainBundleClass(CTShareProfitView.class);
    imgView.qrCode = ivCode;
    imgView.user = user;
    UIView *containerView = [UIView new];
    [containerView insertSubview:imgView atIndex:0];

    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(600);
    }];
    [containerView layoutIfNeeded];
    
    
    dispatch_group_t group = dispatch_group_create();
    __weak typeof(imgView) weakImgView = imgView;
    dispatch_group_enter(group);
    [imgView.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:backgroundImg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [imgView.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:ivCodeImg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIImage *viewImage = [weakImgView snapshotImage];
        if(completed){
            completed(viewImage);
        }
        [containerView class];
    });
    
}

- (void)setUser:(CTUser *)user{
    _user = user;
    [_userheadImageView sd_setImageWithURL:[NSURL URLWithString:_user.headimg]];
    _usernameLabel.text = _user.nickname;
    _userlevelLabel.text = _user.level_txt;
    self.profit = _user.all_money;
    self.balance = _user.valuation_money;
}
- (void)setProfit:(NSString *)profit{
    _profit = profit;
    if([_profit floatValue]){
        NSString *str = [NSString stringWithFormat:@"已提现%@元",_profit];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
        [string addAttributes:@{NSFontAttributeName:CTPsbFont(45)} range:[str rangeOfString:_profit]];
        _attractiveProfitLabel.attributedText = string;
        _attractiveProfitLabel.hidden = NO;
    }
    else{
        _attractiveProfitLabel.hidden = YES;
        _attractiveProfitLabel.text = nil;
        _attractiveProfitLabel.attributedText = nil;
    }
    
}
- (void)setBalance:(NSString *)balance{
    _balance = balance;
    if(_balance.integerValue){
        _attractiveBalanceLabel.hidden = NO;
        NSString *tempStr = [_profit floatValue]?@"还有":@"";
        NSString *str = [NSString stringWithFormat:@"%@%@元即将到账",tempStr,_balance];
        _attractiveBalanceLabel.text = str;
    }
    else{
        _attractiveBalanceLabel.hidden = YES;
        _attractiveBalanceLabel.text = nil;
        _attractiveBalanceLabel.attributedText = nil;
    }
}

- (void)setQrCode:(NSString *)qrCode{
    _qrCode = qrCode;
    _qrCodeLabel.text = [NSString stringWithFormat:@"邀请码 %@",_qrCode];
}
@end
