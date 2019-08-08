//
//  CTEarnDescView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTMyEarnModel.h"

@interface CTEarnDescView : UIView
@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *withdrawButton;
@property (weak, nonatomic) IBOutlet UILabel *lastMonthProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalProfitLabel;
@property (nonatomic, strong) CTMyEarnModel *model;
@end
