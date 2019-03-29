//
//  TimerButton.h
//  YMKMain
//
//  Created by dengchenglin on 2018/7/2.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLTimerButton : UIButton

@property (nonatomic, assign) NSTimeInterval timeInterval;

- (void)startTimer;

@end
