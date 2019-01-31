//
//  CTModuleManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTModuleManager : NSObject

//远程服务映射表
+ (NSDictionary *)moduleMap;

+ (id<CLModuleServiceProtocol>)serviceForStr:(NSString *)serviceStr;

+ (id<CTMainServiceProtocol>)mainService;

+ (id<CTHomeServiceProtocol>)homeService;

+ (id<CTLoginServiceProtocol>)loginService;

+ (id<CTRecommendServiceProtocol>)recommendService;

+ (id<CTSearchTicketServiceProtocol>)searchTicketService;

+ (id<CTMineServiceProtocol>)mineService;

+ (id<CTMemberServiceProtocol>)memberService;

+ (id<CTShareServiceProtocol>)shareService;

+ (id<CTMessageServiceProtocol>)messageService;

+ (id<CTSearchServiceProtocol>)searchService;

+ (id<CTGoodListServiceProtocol>)goodListService;

+ (id<CTWebServiceProtocol>)webService;

+ (id<CTSetServiceProtocol>)setService;

+ (id<CTToolServiceProtocol>)toolService;

+ (id<CTWithdrawServiceProtocol>)withdrawService;

@end
