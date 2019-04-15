//
//  UIButton+Helper.h
//  YMKMain
//
//  Created by dengchenglin on 2018/7/7.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"
@interface UIButton (Helper)

- (RACDisposable *)touchUpInsideSubscribeNext:(void (^)(id x))nextBlock;

@end
