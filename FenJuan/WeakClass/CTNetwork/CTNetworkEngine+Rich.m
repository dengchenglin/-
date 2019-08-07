//
//  CTNetworkEngine+Rich.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine+Rich.h"

#define CTRich(path)   [CTUrlPath(@"rich") stringByAppendingPathComponent:path]

@implementation CTNetworkEngine (Rich)
- (CLRequest *)newUserCourseWithPage:(NSInteger)page size:(NSInteger)size callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(size) forKey:@"size"];
    return [self postWithPath:CTRich(@"new_user_course") params:params showHud:page>1?NO:YES callback:callback];
}

//商学院列表
- (CLRequest *)businessSchoolWithCallback:(CTResponseBlock)callback{
  
    return [self postWithPath:CTRich(@"business_school") params:nil callback:callback];
}
//商学院列表
- (CLRequest *)businessSchoolListWithType:(CTSxyType)type callback:(CTResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(type) forKey:@"cate"];
    return [self postWithPath:CTRich(@"business_school_list") params:params  callback:callback];
}
@end
