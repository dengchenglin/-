//
//  CTShopServiceProtocol.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/11.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLModuleServiceProtocol.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CTShopType){
    CTShopHqg,
    CTShopJhs,
    CTShop99by
};

@protocol CTShopTypeServiceProtocol <NSObject,CLModuleServiceProtocol>
- (UIViewController *)shopViewControllerWithType:(CTShopType)type;
@end

NS_ASSUME_NONNULL_END
