//
//  CTMemberChoicenessView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FJMemberTitleView.h"

@interface FJMemberChoicenessViewfj : UIView

@property (nonatomic, strong) FJMemberTitleView *titleView;

@property (nonatomic, copy) NSArray <NSString *>*imgs;

@property (nonatomic, copy) void(^clickItemBlock)(NSInteger index);

@end
