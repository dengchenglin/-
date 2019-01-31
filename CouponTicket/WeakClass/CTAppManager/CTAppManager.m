//
//  CTAppManager.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAppManager.h"

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
+ (CTUser *)user{
    return [CTAppManager sharedInstance].user;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _user = [CTUser new];
    }
    return self;
}

- (void)saveUserWithInfo:(id)data{
    _user = [CTUser new];
}
@end
