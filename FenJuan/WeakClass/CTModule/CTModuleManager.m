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
             @"ct_share":[self shareService],
             @"ct_message":[self shareService],
             @"ct_search":[self searchService],
             @"ct_good_list":[self goodListService],
             @"ct_web":[self webService],
             @"ct_set":[self setService],
             @"ct_tool":[self toolService],
             @"ct_withdraw":[self withdrawService],
             @"ct_userinfo":[self userInfoService],
             @"ct_promotion":[self promotionService],
             @"ct_cate":[self cateService],
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

+ (id)shareService{
     return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTShareServiceProtocol)];
}

+ (id)messageService{
     return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTMessageServiceProtocol)];
}


+ (id)searchService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTSearchServiceProtocol)];
}

+ (id)goodListService{
     return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTGoodListServiceProtocol)];
}
+ (id)webService{
      return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTWebServiceProtocol)];
}

+ (id)setService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTSetServiceProtocol)];
}

+ (id)toolService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTToolServiceProtocol)];
}

+ (id)withdrawService{
        return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTWithdrawServiceProtocol)];
}

+ (id)userInfoService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTUserInfoServiceProtocol)];
}

+ (id)promotionService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTPromotionServiceProtocol)];
}

+ (id)cateService{
     return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTCateServiceProtocol)];
}

+ (id)judapaiService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTJudapaiServiceProtocol)];
}
+ (id)shipingouService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTShipingouServiceProtocol)];
}

+ (id)mrdkService{
    return [CLModuleManager moduleServiceInstanceForProtocol:@protocol(CTMrdkServiceProtocol)];
}
@end
