//
//  CTNetworkEngine+Common.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/10.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Common.h"

#define CTCommon(path)   [CTUrlPath(@"common") stringByAppendingPathComponent:path]

@implementation CTAppFunctionIo


@end

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
            CTAppFunctionIo *io = [CTAppFunctionIo yy_modelWithDictionary:data];
     
            [[NSUserDefaults standardUserDefaults]setValue:@(io.recom_show) forKey:showRecomKey];
            [[NSUserDefaults standardUserDefaults]setValue:@(io.showRanking) forKey:showRankingKey];
            [CTAppManager sharedInstance].showRecom = io.recom_show;
            [CTAppManager sharedInstance].showRanking = io.showRanking;
            
            [self checkVersionWithIo:io];
        }
    }];
    NSString *showRecom = [[NSUserDefaults standardUserDefaults]objectForKey:showRecomKey];
    NSString *showRanking = [[NSUserDefaults standardUserDefaults]objectForKey:showRankingKey];
    if(showRecom){
        [CTAppManager sharedInstance].showRecom = [showRecom boolValue];
    }
    if(showRanking){
        [CTAppManager sharedInstance].showRanking = [showRanking boolValue];
    }
}
- (void)appFunctionIoWithCallback:(CTResponseBlock)callback{
    [CTRequest postWithPath:CTCommon(@"app_function_io") params:nil showHud:NO callback:callback];
}

- (void)checkVersionWithIo:(CTAppFunctionIo *)io{
    NSString *currentVs = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    if(io.app_ios_version.floatValue>currentVs.floatValue){
        UIAlertView *alt =  [[UIAlertView alloc]initWithTitle:@"" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alt show];
        [alt.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
            if(x.integerValue == 1){
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:io.tbk_app_ios_donwload_url]];
            }
        }];
    }
}
@end
