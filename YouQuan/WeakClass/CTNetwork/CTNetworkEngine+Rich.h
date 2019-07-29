//
//  CTNetworkEngine+Rich.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"
typedef NS_ENUM(NSInteger,CTSxyType){
    CTSxy_xsbk = 1,
    CTSxy_gsjj,
    CTSxy_jyfx,
    CTSxy_spjc
};
NS_ASSUME_NONNULL_BEGIN

@interface CTNetworkEngine (Rich)
//新手教程
- (CLRequest *)newUserCourseWithPage:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback;
//商学院列表
- (CLRequest *)businessSchoolWithCallback:(CTResponseBlock)callback;
//商学院类目列表
- (CLRequest *)businessSchoolListWithType:(CTSxyType)type callback:(CTResponseBlock)callback;

@end

NS_ASSUME_NONNULL_END
