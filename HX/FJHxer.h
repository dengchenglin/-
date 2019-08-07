//
//  FJHxer.h
//  FenJuan
//
//  Created by dengchenglin on 2019/8/7.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

//全局变量混淆
UIKIT_EXTERN NSString * const FQOneNotification;
UIKIT_EXTERN NSString * const FQTwoNotification;
UIKIT_EXTERN NSString * const FQThreeNotification;
UIKIT_EXTERN NSString * const FQFourNotification;
UIKIT_EXTERN NSString * const FQFiveNotification;
UIKIT_EXTERN NSString * const FQSixNotification;
UIKIT_EXTERN NSString * const FQSevenNotification;
UIKIT_EXTERN NSString * const FQEightNotification;
UIKIT_EXTERN NSString * const FQNineNotification;
UIKIT_EXTERN NSString * const FQTenNotification;
UIKIT_EXTERN NSString * const FQElevenNotification;
UIKIT_EXTERN NSString * const FQTwelveNotification;
UIKIT_EXTERN NSString * const FQThirteenNotification;
UIKIT_EXTERN NSString * const FQFourteenNotification;
UIKIT_EXTERN NSString * const FQFifteenNotification;

NS_ASSUME_NONNULL_BEGIN

//混淆时最好把Complie Sources里的文件顺序打乱
@interface FJHxer : NSObject
- (void)method1;
- (int)method2;
@end

NS_ASSUME_NONNULL_END
