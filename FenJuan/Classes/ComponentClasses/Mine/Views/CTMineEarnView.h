//
//  CTMineEarnView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMyEarnModel.h"
@interface CTMineEarnView : UIView
@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@property (weak, nonatomic) IBOutlet UILabel *totalRebateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel3;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel4;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel5;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel6;
@property (weak, nonatomic) IBOutlet UIButton *earnButton;

@property (nonatomic, strong) CTMyEarnModel *model;
@property (nonatomic, strong) CTUser *user;
@end
