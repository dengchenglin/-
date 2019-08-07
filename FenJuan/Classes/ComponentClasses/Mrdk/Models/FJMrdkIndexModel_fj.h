//
//  CTMrdkIndexModel.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJMrdkMyScoreFj.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkMoneyCate:NSObject
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *txt;
@end

@interface CTMrdkActivity:NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *total_money;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *profit_scale;
@property (nonatomic, copy) NSString *people_num;
@property (nonatomic, copy) NSString *signin_num;
@property (nonatomic, copy) NSString *profit_money;
@property (nonatomic, copy) NSString *reg_start_time;
@property (nonatomic, copy) NSString *reg_end_time;
@property (nonatomic, copy) NSString *signin_start_time;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *signin_end_time;
@property (nonatomic, copy) NSString *is_deleted;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *signin_start_time_label;

@property (nonatomic, copy) NSString *signin_end_time_label;
@property (nonatomic, copy) NSString *signin_time_label;
@property (nonatomic, assign) NSInteger signin_surplus_time;
@property (nonatomic, copy) NSString *activity_btn_txt;
@property (nonatomic, assign) NSInteger activity_user_status;

@end

@interface CTMrdkUser:NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *txt;

@end

@interface CTMrdkTodayActivityRecord:NSObject
@property (nonatomic, strong) CTMrdkUser *user1;
@property (nonatomic, strong) CTMrdkUser *user2;
@property (nonatomic, strong) CTMrdkUser *user3;
@end

@interface FJMrdkIndexModel_fj : NSObject
@property (nonatomic, copy) NSString *tip_txt1;
@property (nonatomic, copy) NSArray <CTMrdkMoneyCate *> *money_cate;
@property (nonatomic, strong) CTMrdkActivity *activity;
@property (nonatomic, assign) NSInteger activity_user_status;
@property (nonatomic, copy) NSString *pay_txt;
@property (nonatomic, strong) FJMrdkMyScoreFj *my_score;
@property (nonatomic, strong) CTMrdkTodayActivityRecord *today_activity_record;
@end

NS_ASSUME_NONNULL_END
