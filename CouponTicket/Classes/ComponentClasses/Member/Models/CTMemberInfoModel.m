//
//  CTMemberInfoModel.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMemberInfoModel.h"
@implementation CTMemberRebateModel
@end
@implementation CTMemberGradePowerModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"Id":@"id"};
}
@end
@implementation CTMemberUpgradeConditionModel
@end
@implementation CTMemberInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"user":CTUser.class,@"user_rebate":CTMemberRebateModel.class,@"grade_power":CTMemberGradePowerModel.class,@"upgrade_condition":CTMemberUpgradeConditionModel.class};
}
@end
