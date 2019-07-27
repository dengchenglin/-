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

- (UIViewController *)pushShareFromViewController:(UIViewController *)viewController;

- (void)pushShareFromViewController:(UIViewController *)viewController goodId:(NSString *)goodId;

- (void)pushShareFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel kind:(CTShopKind)kind;

- (void)pushMyInviteCodeFromViewController:(UIViewController *)viewController;

- (void)createGoodsPreviewWithImages:(NSArray <UIImage *>*)images models:(NSArray <CTGoodsModel *> *)models completed:(void(^)(NSArray <UIImage *>* images))completed;


@end
