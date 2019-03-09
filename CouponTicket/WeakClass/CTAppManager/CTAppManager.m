//
//  CTAppManager.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAppManager.h"

#import "KeychainTool.h"

#define CTLoginInfoKey @"CTLoginInfoKey"

@implementation CTWithdrawInfo

- (NSString *)account{
    return @"13138878446";
}

- (NSString *)name{
    return @"老林sir";
}

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

- (NSString *)mobile{
    return @"13138878446";
}


@end

@implementation CTAppManager

SINGLETON_FOR_CLASS_IMP(CTAppManager)

+ (BOOL)logined{
    return [CTAppManager sharedInstance].user;
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

- (instancetype)init
{
    self = [super init];
    if (self) {
        id data = [KeychainTool load:CTLoginInfoKey];
        if(data){
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
- (void)logout{
    _user = nil;
    [KeychainTool save:CTLoginInfoKey data:nil];
}
@end
