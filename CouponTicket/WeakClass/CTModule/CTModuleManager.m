//
//  CTModuleManager.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTModuleManager.h"

#import "CLModuleManager.h"

@implementation CTModuleManager

+ (NSDictionary *)moduleMap{
    return @{@"ct_main":[self mainService],
             @"ct_home":[self homeService],
             @"ct_login":[self loginService],
             @"ct_search_ticket":[self searchTicketService],
             @"ct_mine":[self mineService],
             @"ct_member":[self memberService],
             @"ct_recommend":[self recommendService],
          };
}

+ (id<CLModuleServiceProtocol>)serviceForStr:(NSString *)serviceStr{
    
    return [self moduleMap][serviceStr];
}


+ (id)mainService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTMainServiceProtocol)];
}

+ (id)homeService{
      return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTHomeServiceProtocol)];
}

+ (id)loginService{
     return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTLoginServiceProtocol)];
}

+ (id)recommendService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTRecommendServiceProtocol)];
}

+ (id)searchTicketService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTSearchTicketServiceProtocol)];
}

+ (id)mineService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTMineServiceProtocol)];
}

+ (id)memberService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTMemberServiceProtocol)];
}

@end
