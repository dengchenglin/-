//
//  CTThirtyProfitView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJEarnTrendModelfj.h"
#import "CTUserInfoModel.h"
@interface CTThirtyProfitView : UIView
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (nonatomic, strong) FJEarnTrendModelfj *model;
@property (nonatomic, strong) CTUserInfoModel *userInfo;
@end
