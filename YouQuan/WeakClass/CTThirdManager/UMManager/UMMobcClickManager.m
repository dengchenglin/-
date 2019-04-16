
//
//  UMMobcClickManager.m
//  YouQuan
//
//  Created by dengchenglin on 2019/4/16.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "UMMobcClickManager.h"
#import <UMCAnalytics/UMAnalytics/MobClick.h>
#import <UMCCommonLog/UMCommonLog/UMCommonLogManager.h>
@implementation UMMobcClickManager

+ (void)config{
    [MobClick setScenarioType:E_UM_NORMAL];
    [UMCommonLogManager setUpUMCommonLogManager];
}

@end
