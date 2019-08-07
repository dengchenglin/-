//
//  CTMarkPayHelper.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMarkPayHelper.h"
#import "CTAlertHelper+WithdrawPsd.h"
#import <AlipaySDK/AlipaySDK.h>
#define CTBackScheme @"hjtalent"

@implementation CTMarkPayHelper
+ (void)payWithType:(CTMrdkPayType)type amount:(NSString *)amount activityId:(NSString *)activityId success:(void(^)(id value))success{
    if(type == CTMrdkPayAmount){
//        [CTAlertHelper showPayPasswordViewWithTitle:@"输入支付密码" callback:^(NSString *password) {
//            [CTRequest sa_regWithPayType:CTMrdkPayAmount money:amount password:password activityId:activityId callback:^(id data, CLRequest *request, CTNetError error) {
//                if(!error){
//                    if(success){
//                        success(data);
//                    }
//                }
//            }];
//        }];
    }
    if(type == CTMrdkPayAlipay){
        [CTRequest sa_regWithPayType:CTMrdkPayAlipay money:amount password:nil activityId:activityId callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
                NSString *payOrder = data[@"payData"];
                [[AlipaySDK defaultService]payOrder:payOrder fromScheme:CTBackScheme callback:^(NSDictionary *resultDic) {
                    if([resultDic[@"resultStatus"] integerValue] == 9000){
                        if(success){
                            success(data);
                        }
                    }
                }];
            }
        }];
    }
}
@end
