//
//  CTSortButton.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTUpDownControl.h"

@interface CTSortButton : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL sorted;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, copy) UIColor *normalColor;

@property (nonatomic, copy) UIColor *selectedColor;

@property (nonatomic, assign) CTUpSortStatus defaultStatus;

@property (nonatomic, copy) void (^clickBlock)(CTSortButton *target);

@end
