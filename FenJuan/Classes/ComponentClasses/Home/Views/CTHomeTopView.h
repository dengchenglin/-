//
//  CTHomeTopView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTHomeNavBar.h"

#import "CTHomeSearchBar.h"

#import "CTMainCategoryControl.h"

@interface CTHomeTopView : UIView
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, strong) CTHomeNavBar *navBar;

@property (nonatomic, strong) CTHomeSearchBar *searchBar;

@property (nonatomic, strong) CTMainCategoryControl *categoryControl;

@property (nonatomic, copy) NSArray <CTCategoryModel *>*categoryModels;

@property (nonatomic, copy) void(^clickCategoryBlock)(NSInteger index);

@end
