//
//  CTAppConfig.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAppConfig.h"
#import "CTNetworkEngine+Common.h"
#ifdef DEBUG
#import "PLeakSniffer.h"
#endif


@implementation CTAppConfig

+ (void)config{

    [self configSniffer];
    [CTRequest iosFunctionIo];
//    [IQKeyboardManager sharedManager].enable = NO;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

+ (void)configSniffer{
#ifdef DEBUG
    [[PLeakSniffer sharedInstance]installLeakSniffer];
#endif
}

@end
