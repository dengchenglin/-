//
//  CTHomeNavView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTActivityModel.h"

@interface CTHomeNavView : UIView

@property (nonatomic, copy) NSArray <CTActivityModel *> *activitys;

@property (nonatomic, copy) void (^clickItemBlock)(CTActivityModel *model);

@end
