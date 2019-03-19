//
//  CTMemberInfoModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CTMemberRebateModel:NSObject
@property (nonatomic, copy) NSString *fx_level;
@property (nonatomic, copy) NSString *fx_scale;
@end
@interface CTMemberGradePowerModel:NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@end
@interface CTMemberUpgradeConditionModel:NSObject
@property (nonatomic, copy) NSString *txt1;
@property (nonatomic, copy) NSString *txt2;
@property (nonatomic, copy) NSString *txt3;
@end
@interface CTMemberInfoModel : NSObject
@property (nonatomic, strong) CTUser *user;
@property (nonatomic, copy) NSArray <CTMemberRebateModel *> *user_rebate;
@property (nonatomic, copy) NSArray <CTMemberGradePowerModel *> *grade_power;
@property (nonatomic, strong) CTMemberUpgradeConditionModel *upgrade_condition;
@end
