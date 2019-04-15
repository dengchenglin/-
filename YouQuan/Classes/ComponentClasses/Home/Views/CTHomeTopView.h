//
//  CTHomeTopView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTHomeNavBar.h"

#import "CTMainCategoryControl.h"

@interface CTHomeTopView : UIView

@property (nonatomic, strong) CTHomeNavBar *navBar;

@property (nonatomic, strong) CTMainCategoryControl *categoryControl;

@property (nonatomic, copy) NSArray <CTCategoryModel *>*categoryModels;

@property (nonatomic, copy) void(^clickCategoryBlock)(NSInteger index);

@end
