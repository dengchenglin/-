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

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *balance;

@end

@interface CTAppManager : NSObject

@property (nonatomic, weak) UITabBarController *mainTab;

@property (nonatomic, strong,readonly) CTUser *user;

SINGLETON_FOR_CLASS_DEF

+ (void)showLogin;

+ (BOOL)logined;

+ (void)logout;

+ (CTUser *)user;

- (void)saveUserWithInfo:(id)data;

@end
