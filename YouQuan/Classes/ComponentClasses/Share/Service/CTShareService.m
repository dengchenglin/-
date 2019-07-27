//
//  CTShareService.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTShareService.h"

#import "CTShareViewController.h"

#import "CTGoodsShareViewController.h"
#import "CTInviteCodeViewController.h"
#import "CTGoodsPreview.h"
#import "CTNetworkEngine+Goods.h"

@implementation CTShareService

CL_EXPORT_MODULE(CTShareServiceProtocol)

- (UIViewController *)rootViewController{
    return [CTShareViewController new];
}

- (UIViewController *)pushShareFromViewController:(UIViewController *)viewController{
    CTShareViewController *vc = [CTShareViewController new];
    if([CTAppManager logined]){
        [viewController.navigationController pushViewController:vc animated:YES];
    }
    else{
        [[CTModuleManager loginService] showLoginFromViewController:viewController success:^{
            [viewController.navigationController pushViewController:vc animated:YES];
        } failure:nil];
    }
    return vc;
}

- (void)pushShareFromViewController:(UIViewController *)viewController goodId:(NSString *)goodId{
    CTGoodsShareViewController *vc = [CTGoodsShareViewController new];
    vc.goodId = goodId;
    [viewController.navigationController pushViewController:vc animated:YES];
}

- (void)pushMyInviteCodeFromViewController:(UIViewController *)viewController{
    CTInviteCodeViewController *vc = [CTInviteCodeViewController new];
    [viewController.navigationController pushViewController:vc animated:YES];
}

- (void)pushShareFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel kind:(CTShopKind)kind{
    CTGoodsShareViewController *vc = [CTGoodsShareViewController new];
    vc.viewModel = viewModel;
    vc.goodId = viewModel.model.item_id;
    vc.kind = kind;
    [viewController.navigationController pushViewController:vc animated:YES];
}

- (void)createGoodsPreviewWithImages:(NSArray <UIImage *>*)images models:(NSArray <CTGoodsModel *> *)models completed:(void(^)(NSArray <UIImage *>* images))completed{
    NSMutableArray <CTGoodsModel *>*array = [NSMutableArray array];
    NSLock *lock = [NSLock new];
    static int imagekey;
    dispatch_group_t group = dispatch_group_create();
    for(int i = 0;i < models.count;i ++){
        dispatch_group_enter(group);
        CLRequest *request = [CTRequest goodsShareWithId:models[i].item_id callback:^(id data, CLRequest *request, CTNetError error) {
            
            if(!error){
                [lock lock];
                CTGoodsModel *model = [CTGoodsModel yy_modelWithDictionary:data];
                model.image = objc_getAssociatedObject(request, &imagekey);
                [array addObject:model];
                [lock unlock];
            }
            dispatch_group_leave(group);
        }];
        objc_setAssociatedObject(request, &imagekey, [images safe_objectAtIndex:i], OBJC_ASSOCIATION_COPY_NONATOMIC);
        
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [CTGoodsPreview createGoodsPreviewWithImages:[array map:^id(NSInteger index, CTGoodsModel *element) {
            return element.image?:[UIImage new];
        }] models:array completed:completed];
    });
}
@end
