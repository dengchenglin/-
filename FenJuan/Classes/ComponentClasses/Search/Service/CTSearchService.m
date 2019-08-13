//
//  CTSearchService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchService.h"

#import "CTSearchViewController.h"

#import "FJGoodSearchViewControllerfj.h"

#import "FJGoodResultViewControllerfj.h"

@implementation CTSearchService

CL_EXPORT_MODULE(CTSearchServiceProtocol)

- (UIViewController *)rootViewController{
    return [FJGoodSearchViewControllerfj new];
}

- (UIViewController *)fj_goodResultViewControllerWithKeyword:(NSString *)keyword{
    FJGoodResultViewControllerfj *vc = [FJGoodResultViewControllerfj new];
    vc.keyword = keyword;
    vc.title = keyword;
    return vc;
}

@end
