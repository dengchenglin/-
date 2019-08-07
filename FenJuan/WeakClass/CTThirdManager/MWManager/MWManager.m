

//
//  MWManager.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "MWManager.h"
#import <MagicWindowSDK/MWApi.h>

#define MagicKey @"6GKNQYWAYDSHY3BQPQPKK9IPXR7X8CMF"
@implementation MWManager

+ (void)initSDK{
    [MWApi registerApp:MagicKey];
    [MWApi registerMLinkHandlerWithKey:@"youquan" handler:^(NSURL *url, NSDictionary *params) {
#ifdef DEBUG
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"魔窗test" message:[params yy_modelToJSONString] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alt show];
#endif
        if(params[@"json"]){
            NSString *jsonString = [params objectForKey:@"json"];
            NSDictionary *json = [jsonString jsonValueDecoded];
            CTActivityModel *info = [CTActivityModel yy_modelWithDictionary:json];
            [CTModuleHelper showViewControllerWithModel:info];
        }
    }];
    [MWApi registerMLinkDefaultHandler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
        NSLog(@"%@",params);
    }];
}

+ (void)routeMlink:(NSURL *)url{
    return [MWApi routeMLink:url];
}

+ (BOOL)continueUserActivity:(nonnull NSUserActivity *)userActivity{
    return [MWApi continueUserActivity:userActivity];
}
@end
