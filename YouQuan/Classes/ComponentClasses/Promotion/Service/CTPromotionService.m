//
//  CTPromotionService.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPromotionService.h"
#import "CTPromotionPageController.h"
@implementation CTPromotionService
CL_EXPORT_MODULE(CTPromotionServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTPromotionPageController new];
}

@end
