//
//  UIPasteboard+Helper.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "UIPasteboard+Helper.h"

#define CTPasteTextChangeCountKey @"CTPasteTextChangeCountKey"

@implementation UIPasteboard (Helper)

- (NSString *)_newestString{
    NSInteger lastChangeCount = [[[NSUserDefaults standardUserDefaults] objectForKey:CTPasteTextChangeCountKey] integerValue];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if(pasteboard.changeCount != lastChangeCount && pasteboard.string.length != 0){
        [[NSUserDefaults standardUserDefaults]setValue:@(pasteboard.changeCount) forKey:CTPasteTextChangeCountKey];
        return pasteboard.string;
    }
    return nil;
}

@end
