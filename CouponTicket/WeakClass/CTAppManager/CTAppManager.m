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

@implementation CTWithdrawInfo


@end

@implementation CTUser

- (instancetype)init
{
    self = [super init];
    if (self) {
        _withInfo = [CTWithdrawInfo new];
    }
    return self;
}


@end

@implementation CTAppManager

SINGLETON_FOR_CLASS_IMP(CTAppManager)

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
