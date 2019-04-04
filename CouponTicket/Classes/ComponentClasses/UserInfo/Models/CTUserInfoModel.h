//
//  CTUserInfoModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTEarnIndexModel.h"
@interface CTUserInfoModel : NSObject
@property (nonatomic, copy) NSArray <CTEarnIndexModel *>*day30_lists;
@property (nonatomic, copy) NSString *day30_money;
@property (nonatomic, strong) CTUser *user;
@property (nonatomic, copy) NSString *trend_chart_url;
@end
