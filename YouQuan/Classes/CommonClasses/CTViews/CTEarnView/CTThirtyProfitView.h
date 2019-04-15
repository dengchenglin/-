//
//  CTThirtyProfitView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTEarnTrendModel.h"
#import "CTUserInfoModel.h"
@interface CTThirtyProfitView : UIView
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (nonatomic, strong) CTEarnTrendModel *model;
@property (nonatomic, strong) CTUserInfoModel *userInfo;
@end
