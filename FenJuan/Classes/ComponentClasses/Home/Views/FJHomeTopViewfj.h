//
//  CTHomeTopView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FJHomeNavBarfj.h"

#import "FJHomeSearchBarfj.h"

#import "CTMainCategoryControl.h"

@interface FJHomeTopViewfj : UIView
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, strong) FJHomeNavBarfj *navBar;

@property (nonatomic, strong) FJHomeSearchBarfj *searchBar;

@property (nonatomic, strong) CTMainCategoryControl *categoryControl;

@property (nonatomic, copy) NSArray <CTCategoryModel *>*categoryModels;

@property (nonatomic, copy) void(^clickCategoryBlock)(NSInteger index);

@end
