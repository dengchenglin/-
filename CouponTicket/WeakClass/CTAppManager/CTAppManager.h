//
//  CTAppManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTWithdrawInfo:NSObject

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *name;

@end

@interface CTUser  :NSObject


@property (nonatomic, strong) CTWithdrawInfo *withInfo;

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *iv_code;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *level_txt;
@property (nonatomic, copy) NSString *tbk_relation_id;
@property (nonatomic, copy) NSString *pay_pwd;
@property (nonatomic, copy) NSString *tbk_account_name;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *type;
@end

@interface CTAppManager : NSObject

@property (nonatomic, weak) UITabBarController *mainTab;

@property (nonatomic, strong,readonly) CTUser *user;

@property (nonatomic, copy,readonly) NSString *token;

SINGLETON_FOR_CLASS_DEF

+ (void)showLogin;

+ (BOOL)logined;

+ (void)logout;

+ (CTUser *)user;

+ (void)saveUserWithInfo:(id)data;

+ (void)saveToken:(NSString *)token;

@end
