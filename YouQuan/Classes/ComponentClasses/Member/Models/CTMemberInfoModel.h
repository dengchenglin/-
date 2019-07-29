//
//  CTMemberInfoModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTMemberRebateModel.h"
@interface CTMemberGradePowerModel:NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@end

@interface CTMemberInfoModel : NSObject
@property (nonatomic, strong) CTUser *user;
@property (nonatomic, copy) NSArray <CTMemberRebateModel *> *user_rebate;
@property (nonatomic, copy) NSArray <CTMemberGradePowerModel *> *grade_power;
@property (nonatomic, strong) CTMemberUpgradeConditionModel *upgrade_condition;
@property (nonatomic, copy) NSArray <CTActivityModel *> *advs;
@property (nonatomic, assign, readonly) BOOL showUpgrade;
@end
