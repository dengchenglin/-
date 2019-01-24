//
//  CTMessageListViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseListViewController.h"

typedef NS_ENUM(NSInteger,CTMessageKind) {
    CTMessageSystem,
    CTMessageNotification
};

@interface CTMessageListViewController : CTBaseListViewController

@property (nonatomic, assign) CTMessageKind messageKind;

@end
