//
//  CTHomeService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHomeServicefj.h"

#import "FJHomePageControllerfj.h"

@implementation FJHomeServicefj

CL_EXPORT_MODULE(CTHomeServiceProtocol)

- (UIViewController *)rootViewController{
    return [FJHomePageControllerfj new];
}

@end
