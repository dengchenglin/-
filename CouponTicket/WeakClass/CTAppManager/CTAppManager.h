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
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *level_txt;
@property (nonatomic, copy) NSString *tbk_relation_id;
@property (nonatomic, copy) NSString *pay_pwd;
@property (nonatomic, copy) NSString *tbk_account_name;
@end

@interface CTAppManager : NSObject

@property (nonatomic, weak) UITabBarController *mainTab;

@property (nonatomic, strong,readonly) CTUser *user;

SINGLETON_FOR_CLASS_DEF

+ (void)showLogin;

+ (BOOL)logined;

+ (void)logout;

+ (CTUser *)user;

+ (void)saveUserWithInfo:(id)data;

@end
