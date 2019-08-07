//
//  CTJdpService.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTJdpService.h"
#import "CTJdpPageViewController.h"
@implementation CTJdpService
CL_EXPORT_MODULE(CTJudapaiServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTJdpPageViewController new];
}
@end
