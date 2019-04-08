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
    CTUserEditQQ
};

@protocol CTUserInfoServiceProtocol <NSObject,CLModuleServiceProtocol>

- (UIViewController *)viewControllerForUserId:(NSString *)userId;

- (UIViewController *)viewControllerForType:(CTUserEditType)type;

@end
