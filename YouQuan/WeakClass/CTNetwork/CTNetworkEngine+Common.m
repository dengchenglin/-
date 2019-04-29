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
- (void)appFunctionIo{
    NSString *showRecomKey = @"showRecomKey";
    NSString *showRankingKey = @"showRankingKey";
    [self postWithPath:CTCommon(@"app_function_io") params:nil showHud:NO callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error && data){
            BOOL showRecom = [[NSString stringWithFormat:@"%@",data[@"recom_show"]] boolValue];
            BOOL showRanking = [[NSString stringWithFormat:@"%@",data[@"rp_showRanking"]] boolValue];
            [[NSUserDefaults standardUserDefaults]setValue:@(showRecom) forKey:showRecomKey];
            [[NSUserDefaults standardUserDefaults]setValue:@(showRanking) forKey:showRankingKey];
            [CTAppManager sharedInstance].showRecom = showRecom;
            [CTAppManager sharedInstance].showRanking = showRanking;
        }
    }];
    NSString *showRecom = [[NSUserDefaults standardUserDefaults]objectForKey:showRecomKey];
    NSString *showRanking = [[NSUserDefaults standardUserDefaults]objectForKey:showRankingKey];
    [CTAppManager sharedInstance].showRecom = [showRecom boolValue];
    [CTAppManager sharedInstance].showRanking = [showRanking boolValue];
}
@end
