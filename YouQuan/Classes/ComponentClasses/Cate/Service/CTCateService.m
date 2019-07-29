//
//  CTCateService.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTCateService.h"
#import "CTCateViewController.h"
@implementation CTCateService
CL_EXPORT_MODULE(CTCateServiceProtocol)
- (UIViewController *)rootViewController{
    return [CTCateViewController new];
}
@end
