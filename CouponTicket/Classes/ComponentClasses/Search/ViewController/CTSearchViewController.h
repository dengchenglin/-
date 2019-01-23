//
//  CTSearchViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTSearchViewController : CTBaseViewController

@property (nonatomic, strong) UITableView *dataTableView;

- (void)searchKeyword:(NSString *)keyword;

@end
