
//
//  UMMobcClickManager.m
//  YouQuan
//
//  Created by dengchenglin on 2019/4/16.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "UMMobcClickManager.h"
#import <UMAnalytics/MobClick.h>
#import <UMCommonLog/UMCommonLogManager.h>
@implementation UMMobcClickManager

+ (void)config{
    [MobClick setScenarioType:E_UM_NORMAL];
    [UMCommonLogManager setUpUMCommonLogManager];
}

@end
