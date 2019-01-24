//
//  CTGoodSortView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTGoodDefine.h"

@interface CTGoodSortView : UIView

@property (nonatomic, copy) UIColor *normalColor;

@property (nonatomic, copy) UIColor *selectedColor;

@property (nonatomic, copy) UIColor *upDownNormalColor;

@property (nonatomic, copy) UIColor *upDownSelectedColor;

@property (nonatomic, assign) BOOL showSilder;

@property (nonatomic, copy) void (^clickBlock)(CTGoodSortType type);

@end
