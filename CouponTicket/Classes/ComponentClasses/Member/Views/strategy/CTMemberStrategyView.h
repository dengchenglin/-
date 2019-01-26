//
//  CTMemberStrategyView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTMemberTitleView.h"

@interface CTMemberStrategyView : UIView

@property (nonatomic, strong) CTMemberTitleView *titleView;

@property (nonatomic, copy) NSArray *models;

@property (nonatomic, copy) void(^clickItemBlock)(NSInteger index);

@end
