//
//  CTNetworkEngine+Common.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/10.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Common.h"

#define CTCommon(path)   [CTUrlPath(@"common") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Common)

- (void)iosFunctionIo{
    NSString *showMemberKey = @"ios_function_io";
  
    [self postWithPath:CTCommon(@"ios_function_io") params:nil showHud:NO callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error && data){
            BOOL showMember = [[NSString stringWithFormat:@"%@",data] boolValue];
            [[NSUserDefaults standardUserDefaults]setValue:@(showMember) forKey:showMemberKey];
            [CTAppManager sharedInstance].showMember = showMember;
        }
    }];
    NSString *showMember = [[NSUserDefaults standardUserDefaults]objectForKey:showMemberKey];
    [CTAppManager sharedInstance].showMember = [showMember boolValue];
}
@end
