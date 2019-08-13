//
//  CTMemberEquityView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FJMemberTitleView.h"

#import "FJMemberEquityItemfj.h"

#import "CTMemberInfoModel.h"

@interface CTMemberEquityView : UIView

@property (nonatomic, strong) FJMemberTitleView *titleView;

@property (nonatomic, copy) NSArray <FJMemberRebateModelfj *>*models;


@end
