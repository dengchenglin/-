//
//  UIViewController+Helper.h
//  LightMaster
//
//  Created by Dankal on 2018/12/30.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Helper)

@end

@interface UIViewController (Helper)

@property (nonatomic, assign) BOOL willPop;

@property (nonatomic, assign) BOOL isPop;//在视图显示时判断是否是pop回来的

@end


