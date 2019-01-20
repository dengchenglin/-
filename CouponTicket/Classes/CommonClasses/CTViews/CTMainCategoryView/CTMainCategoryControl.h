//
//  CTMainCategoryControl.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMSegmentedControl.h"

#import "CTMainCategoryView.h"

@interface CTMainCategoryControl : UIView

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@property (nonatomic, strong) CTMainCategoryView *categoryView;

@property (nonatomic, strong) UIButton *unfoldButton;

@property (nonatomic, copy) NSArray <NSString *>*titles;

@end
