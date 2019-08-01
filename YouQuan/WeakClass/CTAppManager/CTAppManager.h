//
//  CTAppManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CTMemberUpgradeConditionModel:NSObject
@property (nonatomic, copy) NSString *txt1;
@property (nonatomic, copy) NSString *txt2;
@property (nonatomic, copy) NSString *txt3;
@end
@interface CTUser  :NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *iv_code;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *level_txt;
@property (nonatomic, copy) NSString *fx_txt;
@property (nonatomic, copy) NSString *tbk_relation_id;
@property (nonatomic, copy) NSString *tbk_account_name;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL ishas_pay_pwd;
@property (nonatomic, assign) BOOL ishas_cash_account;
@property (nonatomic, copy) NSString *cash_account;
@property (nonatomic, copy) NSString *cash_name;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *wx;
@property (nonatomic, copy) NSString *all_money;
@property (nonatomic, copy) NSString *valuation_money;

@property (nonatomic, strong) CTMemberUpgradeConditionModel *upgrade_condition;

//直属用户
@property (nonatomic, copy) NSString *people_num;
@end

@interface CTAppManager : NSObject

@property (nonatomic, weak) UITabBarController *mainTab;

@property (nonatomic, strong,readonly) CTUser *user;

@property (nonatomic, copy,readonly) NSString *token;

@property (nonatomic, copy) NSString *apns_token;

@property (nonatomic, assign) BOOL showMember;
@property (nonatomic, assign) BOOL showRanking;
@property (nonatomic, assign) BOOL showRecom;

SINGLETON_FOR_CLASS_DEF

+ (void)showLogin;

+ (BOOL)logined;

+ (void)logout;

+ (CTUser *)user;

+ (void)saveUserWithInfo:(id)data;

+ (void)saveToken:(NSString *)token;

@end
