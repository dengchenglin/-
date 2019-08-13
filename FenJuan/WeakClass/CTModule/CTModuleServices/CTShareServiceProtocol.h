//
//  CTShareServiceProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

#import "CTGoodsViewModel.h"

@protocol CTShareServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)fj_pushShareFromViewController:(UIViewController *)viewController;

- (void)fj_pushShareFromViewController:(UIViewController *)viewController goodId:(NSString *)goodId;

- (void)fj_pushShareFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel kind:(CTShopKind)kind;

- (void)fj_pushMyInviteCodeFromViewController:(UIViewController *)viewController;

- (void)fj_createGoodsPreviewWithImages:(NSArray <UIImage *>*)images models:(NSArray <CTGoodsModel *> *)models completed:(void(^)(NSArray <UIImage *>* images))completed;


@end
