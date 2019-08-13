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

+ (void)judgeLogin:(void(^)(void))completed{
    
}

+ (void)showLogin{
    UIViewController *vc = [UIUtil getCurrentViewController];
    if(vc.tabBarController){
        [[CTModuleManager loginService] fj_showLoginFromViewController:vc callback:nil];
    }
}



+ (BOOL)logined{
    return [CTAppManager sharedInstance].token?YES:NO;
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
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:data];
        [dic setValue:value forKey:key];
        [KeychainTool save:CTLoginInfoKey data:dic];
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
        _showRecom = YES;
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
}
@end
@implementation CTUser
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"upgrade_condition":CTMemberUpgradeConditionModel.class};
}

@end
@implementation CTMemberUpgradeConditionModel
@end
