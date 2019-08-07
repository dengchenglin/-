//
//  CTUserInfoServiceProtocol.h
//  CouponTicket
//
//  Created by Dankal on 2019/2/14.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

typedef NS_ENUM(NSInteger,CTUserEditType){
    CTUserEditIcon,
    CTUserEditWX,
    CTUserEditQQ,
    CTUserEditRemark
};

@protocol CTUserInfoServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)viewControllerForUserId:(NSString *)userId;

- (UIViewController *)viewControllerForType:(CTUserEditType)type;

- (UIViewController *)viewControllerForType:(CTUserEditType)type success:(void(^)(id value))success;

- (UIViewController *)viewControllerForType:(CTUserEditType)type Id:(NSString *)Id success:(void(^)(id value))success;
@end
