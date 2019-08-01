//
//  CTUserEditViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

NSString *GetEditTitleStr(CTUserEditType type);

@interface CTUserEditViewController : CTBaseViewController
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, assign) CTUserEditType type;
@property (nonatomic, copy) void (^success)(id value);
@end
