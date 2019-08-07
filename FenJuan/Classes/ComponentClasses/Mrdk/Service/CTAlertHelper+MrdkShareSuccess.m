//
//  CTAlertHelper+MrdkShareSuccess.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlertHelper+MrdkShareSuccess.h"
#import "CTMrdkShareSuccessView.h"
@implementation CTAlertHelper (MrdkShareSuccess)
+ (void)showMrdkShareSuccessWithCallback:(void(^)(NSUInteger index))callback{
    CTMrdkShareSuccessView *alertView = NSMainBundleClass(CTMrdkShareSuccessView.class);
    alertView.callback = callback;
    [self showAlertView:alertView callback:nil];
}
@end
