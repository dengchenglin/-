
//
//  CTModuleHelper.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTModuleHelper.h"

static const int linkActions_assoc_key;

@implementation CTModuleHelper

+ (NSDictionary *)linkActions{
    NSDictionary *actions = objc_getAssociatedObject(self, &linkActions_assoc_key);
    
    if(!actions){
        actions = @{@(CTLinkWeb):^UIViewController *(CTActivityModel *info,UIViewController *pushingVc){
            UIViewController *vc = [[CTModuleManager webService] fj_pushWebFromViewController:pushingVc url:info.href];
            vc.title = info.title;
            return vc;
        },@(CTLinkGoodsDetail):^UIViewController *(CTActivityModel *info,UIViewController *pushingVc){
            UIViewController *vc = [[CTModuleManager goodListService]fj_goodDetailViewControllerWithGoodId:info.href];
            [pushingVc.navigationController pushViewController:vc animated:YES];
            return vc;
        },@(CTLinkRegister):^UIViewController *(CTActivityModel *info,UIViewController *pushingVc){
            [CTAppManager logout];
            UIViewController *vc = [UIUtil getCurrentViewController];
            [[CTModuleManager loginService]fj_showRegisterFromViewController:vc inviteCode:info.href callback:nil];
            return nil;
        }};
        objc_setAssociatedObject(self, &linkActions_assoc_key, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return actions;
}


+ (UIViewController *)showCtVcFromViewController:(UIViewController *)viewController model:(CTActivityModel *)model{
    if(!viewController)return nil;
    UIViewController *(^actionBlock)(CTActivityModel*info,UIViewController *pushingVc) = [self linkActions][@(model.link_type)];
    if(model.link_type == CTLinkRegister){
        if(actionBlock){
            return actionBlock(model,viewController);
        }
    }
    else if(viewController.tabBarController){
        if(actionBlock){
            return actionBlock(model,viewController);
        }
    }
  
    return nil;
}

+ (UIViewController *)showViewControllerWithModel:(CTActivityModel *)model{
    UIViewController *vc = [UIUtil getCurrentViewController];
    if(vc){
        return [self showCtVcFromViewController:vc model:model];
    }
    return nil;
}

@end
