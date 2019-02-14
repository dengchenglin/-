//
//  CTWebService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWebService.h"

#import "CTWebViewController.h"

@implementation CTWebService

CL_EXPORT_MODULE(CTWebServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTWebViewController new];
}

- (UIViewController *)pushWebFromViewController:(UIViewController *)viewController  htmlString:(NSString *)htmlString{
    return [CTWebViewController showWebFromViewController:viewController url:nil htmlString:htmlString isPush:YES];
}

- (UIViewController *)pushWebFromViewController:(UIViewController *)viewController url:(NSString *)url{
    return [CTWebViewController showWebFromViewController:viewController url:url htmlString:nil isPush:YES];
}

- (UIViewController *)showWebFromViewController:(UIViewController *)viewController htmlString:(NSString *)htmlString{
     return [CTWebViewController showWebFromViewController:viewController url:nil htmlString:htmlString isPush:NO];
}

- (UIViewController *)showWebFromViewController:(UIViewController *)viewController url:(NSString *)url{
     return [CTWebViewController showWebFromViewController:viewController url:url htmlString:nil isPush:NO];
}


@end
