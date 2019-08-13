//
//  CTMemberStrategyView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FJMemberTitleView.h"

@interface FJMemberStrategyViewfj : UIView

@property (nonatomic, strong) FJMemberTitleView *titleView;

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, copy) void(^clickItemBlock)(NSInteger index);
@property (nonatomic, strong) NSString *hhwhy;
@property (nonatomic, strong) NSString *nimazale;
@property (nonatomic, strong) NSString *commonpp;
@property (nonatomic, assign) NSInteger wodekahao;
@end
