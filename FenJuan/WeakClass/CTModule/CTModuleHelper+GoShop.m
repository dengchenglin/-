//
//  CTModuleHelper+GoShop.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/26.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTModuleHelper+GoShop.h"

#import "CTNetworkEngine+Goods.h"

@implementation CTModuleHelper (GoShop)
+ (void)goShopFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel{
    
    //通过转链接口获取真正的click_url数据
    void (^goodsUrlConvertBlock)(void(^)(id data)) = ^(void(^getFinalData)(id data)){
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:viewModel.model.goods_title forKey:@"goods_title"];
        [params setValue:viewModel.model.goods_logo forKey:@"goods_logo"];
        [params setValue:viewModel.model.coupon_share_url forKey:@"coupon_share_url"];
        //判断当前用户是否绑定过渠道id
        [CTRequest goodsUrlConvertWithTbGoodsInfo:params callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){//绑定过渠道id 直接返回最终数据
                //先百川授权
                [AliTradeManager autoWithViewController:viewController successCallback:^(ALBBSession *session) {
                    if(getFinalData){
                        getFinalData(data);
                    }
                }];
            }
            else{//如果未绑定过渠道id 需要先进行淘宝h5授权  h5授权成功后js返回数据与绑定成功后的数据一样
                NSInteger status = [data[@"status"] integerValue];
                if(status == 403){
                    NSString *tbAuthUrl = data[@"data"];
                    [[CTModuleManager webService]tbAuthFromViewController:viewController url:tbAuthUrl callback:^(id data) {
                        if(getFinalData){
                            getFinalData(data);
                        }
                    }];
                }
                else{
                    [MBProgressHUD showMBProgressHudWithTitle:data[@"info"]];
                }
            }
        }];
    };
    
    //下单 唤起手淘
    void (^goShop)(void) = ^{
        //先获取最终的数据
        goodsUrlConvertBlock(^(id data){
            NSString *clickUrl = data[@"click_url"];
            [AliTradeManager openTbWithViewController:viewController url:clickUrl];
        });
    };
    
    //判断是否登录
    void (^judgeLoginBlock)(void(^)(void)) = ^(void(^loginCompleted)(void)){
        if([CTAppManager logined]){
            if(loginCompleted){
                loginCompleted();
            }
        }
        else {
            [[CTModuleManager loginService]showLoginFromViewController:viewController callback:^(BOOL logined) {
                if(logined){
                    if(loginCompleted){
                        loginCompleted();
                    }
                }
            }];
        }
    };
    
    judgeLoginBlock(^{
        goShop();
    });
}

+ (void)shareShopFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel{
    
    //通过转链接口获取真正的click_url数据
    void (^goodsUrlConvertBlock)(void(^)(id data)) = ^(void(^getFinalData)(id data)){
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:viewModel.model.goods_title forKey:@"goods_title"];
        [params setValue:viewModel.model.goods_logo forKey:@"goods_logo"];
        [params setValue:viewModel.model.coupon_share_url forKey:@"coupon_share_url"];
        //判断当前用户是否绑定过渠道id
        [CTRequest goodsUrlConvertWithTbGoodsInfo:params callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){//绑定过渠道id 直接返回最终数据
                //先百川授权
                [AliTradeManager autoWithViewController:viewController successCallback:^(ALBBSession *session) {
                    if(getFinalData){
                        getFinalData(data);
                    }
                }];
            }
            else{//如果未绑定过渠道id 需要先进行淘宝h5授权  h5授权成功后js返回数据与绑定成功后的数据一样
                NSInteger status = [data[@"status"] integerValue];
                if(status == 403){
                    NSString *tbAuthUrl = data[@"data"];
                    [[CTModuleManager webService]tbAuthFromViewController:viewController url:tbAuthUrl callback:^(id data) {
                        if(getFinalData){
                            getFinalData(data);
                        }
                    }];
                }
                else{
                    [MBProgressHUD showMBProgressHudWithTitle:data[@"info"]];
                }
            }
        }];
    };
    
    //判断是否登录
    void (^judgeLoginBlock)(void(^)(void)) = ^(void(^loginCompleted)(void)){
        if([CTAppManager logined]){
            if(loginCompleted){
                loginCompleted();
            }
        }
        else {
            [[CTModuleManager loginService]showLoginFromViewController:viewController callback:^(BOOL logined) {
                if(logined){
                    if(loginCompleted){
                        loginCompleted();
                    }
                }
            }];
        }
    };
    
    judgeLoginBlock(^{
        goodsUrlConvertBlock(^(id data){
            
            [[CTModuleManager shareService]pushShareFromViewController:viewController goodId:viewModel.model.item_id];
        });
    });
}

@end
