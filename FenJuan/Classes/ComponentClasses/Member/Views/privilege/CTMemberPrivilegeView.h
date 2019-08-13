//
//  CTMemberPrivilegeView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FJMemberTitleView.h"

#import "CTMemberPrivilegeItem.h"

#import "CTMemberInfoModel.h"

@interface CTMemberPrivilegeView : UIView

@property (nonatomic, strong) FJMemberTitleView *titleView;

@property (nonatomic, copy) NSArray <CTMemberGradePowerModel *>*models;
@property (nonatomic, strong) NSString *hhwhy;
@property (nonatomic, strong) NSString *nimazale;
@property (nonatomic, strong) NSString *commonpp;
@property (nonatomic, assign) NSInteger wodekahao;
@end
