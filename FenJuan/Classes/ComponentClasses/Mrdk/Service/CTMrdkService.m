//
//  CTMrdkService.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkService.h"
#import "CTMrdkViewController.h"
@implementation CTMrdkService
CL_EXPORT_MODULE(CTMrdkServiceProtocol)
- (UIViewController *)rootViewController{
    return [CTMrdkViewController new];
}

@end
