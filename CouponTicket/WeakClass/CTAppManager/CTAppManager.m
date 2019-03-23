//
//  CTAppManager.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAppManager.h"

#import "KeychainTool.h"

#import "AliTradeManager.h"

#define CTLoginInfoKey @"CTLoginInfoKey"
#define CTUserTokenKey @"CTUserTokenKey"


@implementation CTAppManager

SINGLETON_FOR_CLASS_IMP(CTAppManager)

+ (void)showLogin{
    UIViewController *vc = [UIUtil getCurrentViewController];
    if(vc.tabBarController){
        [[CTModuleManager loginService] showLoginFromViewController:vc callback:nil];
    }
}

+ (BOOL)logined{
    return [CTAppManager sharedInstance].token;
}

+ (void)logout{
    [[CTAppManager sharedInstance] logout];
}

+ (CTUser *)user{
    return [CTAppManager sharedInstance].user;
}

+ (void)saveUserWithInfo:(id)data{
    [[CTAppManager sharedInstance] saveUserWithInfo:data];
}
+ (void)updateUserInfoValue:(NSString *)value key:(NSString *)key{
    id data = [KeychainTool load:CTLoginInfoKey];
    if(data){
        [data setValue:value forKey:@"key"];
        [KeychainTool save:CTLoginInfoKey data:data];
    }
}
+ (id)valueForUserInfoWithKey:(NSString *)key{
    id data = [KeychainTool load:CTLoginInfoKey];
    if(data){
        return data[key];
    }
    return nil;
}

+ (void)saveToken:(NSString *)token{
    [[CTAppManager sharedInstance]saveToken:token];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        id data = [KeychainTool load:CTLoginInfoKey];
         _token = [KeychainTool load:CTUserTokenKey];
        if(data && _token.length){
            _user = [CTUser yy_modelWithDictionary:data];
        }
    }
    return self;
}


- (void)saveUserWithInfo:(id)data{
    [KeychainTool save:CTLoginInfoKey data:data];
    CTUser *user = [CTUser yy_modelWithDictionary:data];
    _user = user;
}
- (void)saveToken:(NSString *)token{
    [KeychainTool save:CTUserTokenKey data:token];
    _token = token;
}
- (void)logout{
    _user = nil;
    _token = nil;
    [KeychainTool save:CTLoginInfoKey data:nil];
    [KeychainTool save:CTUserTokenKey data:nil];
    [AliTradeManager logOut];
}
@end
@implementation CTUser

- (void)setPay_pwd:(NSString *)pay_pwd{
    if(_pay_pwd != pay_pwd){
        _pay_pwd = pay_pwd;
    }
    NSString *key = @"pay_pwd";
    NSString *cachesPay_pwd = [CTAppManager valueForUserInfoWithKey:key];
    if(![cachesPay_pwd isEqualToString:pay_pwd]){
        [CTAppManager updateUserInfoValue:_pay_pwd key:cachesPay_pwd];
    }
}
- (void)setPay_name:(NSString *)pay_name{
    if(_pay_name != pay_name){
        _pay_name = pay_name;
    }
    NSString *key = @"pay_name";
    NSString *cachesPay_name = [CTAppManager valueForUserInfoWithKey:key];
    if(![cachesPay_name isEqualToString:pay_name]){
        [CTAppManager updateUserInfoValue:_pay_name key:key];
    }
}
- (void)setPay_account:(NSString *)pay_account{
    if(_pay_account != pay_account){
        _pay_account = pay_account;
    }
    NSString *key = @"pay_account";
    NSString *cachesPay_account = [CTAppManager valueForUserInfoWithKey:key];
    if(![cachesPay_account isEqualToString:pay_account]){
        [CTAppManager updateUserInfoValue:_pay_account key:key];
    }
}

@end
