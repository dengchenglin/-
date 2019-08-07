//
//  CTHotGoodsServiceProtocol.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLModuleServiceProtocol.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CTHotGoodsSaleType){
    CTHotGoodsSaleDefault = 0,
    CTHotGoodsSaleNew,
    CTHotGoodsSaleToday,
};
@protocol CTHotGoodsServiceProtocol <NSObject,CLModuleServiceProtocol>

@end

NS_ASSUME_NONNULL_END
