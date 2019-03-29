//
//  UIButton+Helper.m
//  YMKMain
//
//  Created by dengchenglin on 2018/7/7.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "UIButton+Helper.h"


@implementation UIButton (Helper)

- (RACDisposable *)touchUpInsideSubscribeNext:(void (^)(id x))nextBlock{
   return [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:nextBlock];
}

@end
