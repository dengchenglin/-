//
//  CTMemberUpgradeView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMemberTitleView.h"
#import "CTMemberUpgradeContainerView.h"

@interface CTMemberUpgradeView : UIView
@property (nonatomic, strong) CTMemberTitleView *titleView;
@property (nonatomic, strong) CTMemberUpgradeContainerView *containerView;
@end
