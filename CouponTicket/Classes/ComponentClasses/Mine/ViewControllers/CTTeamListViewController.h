//
//  CTTeamListViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseListViewController.h"

typedef NS_ENUM(NSInteger,CTTeamKind) {
    CTTeamKindAll,
    CTTeamKindDirectly,
    CTTeamKindMediate
};

@interface CTTeamListViewController : CTBaseListViewController

@property (nonatomic, assign) CTTeamKind teamKind;

@end
