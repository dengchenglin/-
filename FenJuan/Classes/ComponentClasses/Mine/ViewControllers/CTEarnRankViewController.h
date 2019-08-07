//
//  CTEarnRankViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"
#import "CTNestPageController.h"
#import "CTEarnRankModel.h"

@interface CTEarnRankViewController : CTBaseViewController<CTNestSubControllerProtocol>
@property (nonatomic, copy) NSArray <CTEarnRankIndexModel *>*models;
@end
