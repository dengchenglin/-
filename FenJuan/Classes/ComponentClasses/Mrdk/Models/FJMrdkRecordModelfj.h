//
//  CTMrdkRecordModel.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJMrdkRecordModelfj : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *enroll_money;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *pay_no;
@property (nonatomic, copy) NSString *gain_money;
@property (nonatomic, copy) NSString *signin_time;
@property (nonatomic, copy) NSString *signin_time_label;

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL is_deleted;
@property (nonatomic, copy) NSString *create_at;
@end

NS_ASSUME_NONNULL_END
