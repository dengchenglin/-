//
//  CTUpDownControl.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CTSortStatus) {
    CTSortStatusNormal = 0,
    CTSortStatusUp,
    CTSortStatusDown
};

@interface CTUpDownControl : UIView

@property (nonatomic, assign) CTSortStatus status;

@property (nonatomic, copy) UIColor *normalColor;

@property (nonatomic, copy) UIColor *selectedColor;

@end
