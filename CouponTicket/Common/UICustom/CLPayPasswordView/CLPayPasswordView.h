//
//  CLPayPasswordView.h
//  LightMaster
//
//  Created by dengchenglin on 2018/12/21.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CLPayPasswordMaxCount 6

@interface CLPayPasswordView : UIView

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) CGFloat maxCount;

@property (nonatomic, assign) CGFloat count;

@property (nonatomic, copy) void (^passwordCallback)(NSString *password);

@end
