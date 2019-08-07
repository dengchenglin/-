//
//  CTWebService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWebService.h"
#import "CTWebViewController.h"
#import "CTTaoBaoAuthViewController.h"

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
- (UIViewController *)tbAuthFromViewController:(UIViewController *)viewController url:(NSString *)url callback:(void (^)(id data))callback{
    return [CTTaoBaoAuthViewController tbAuthFromViewController:viewController url:url callback:callback];
}
- (void)tbAuthFromViewController:(UIViewController *)viewController completed:(void (^)(void))completed{
    if([CTAppManager user].tbk_relation_id.length){
        if(completed){
            completed();
        }
        return;
    }
    [CTTaoBaoAuthViewController tbAuthFromViewController:viewController callback:^(id data) {
        if(data){
            [CTAppManager user].tbk_relation_id = data[@"data"][@"tbk_relation_id"];
            if(completed){
                completed();
            }
        }
    }];
}
@end
