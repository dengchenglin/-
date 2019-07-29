//
//  CTSearchTextfield.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTSearchTextfield : UITextField
@property (nonatomic, copy) UIColor *logoColor;

@property (nonatomic, copy) void(^searchBlock)(NSString *keyword);

@property (nonatomic, copy) void(^clickSeachBlock)(void);

@end
