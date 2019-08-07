//
//  CTShopKindServiceProtocol.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/11.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLModuleServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CTShopKindServiceProtocol <NSObject,CLModuleServiceProtocol>
- (UIViewController *)shopViewControllerWithKind:(CTShopKind)kind;
@end

NS_ASSUME_NONNULL_END
