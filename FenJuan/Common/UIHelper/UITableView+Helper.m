//
//  UITableView+Helper.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "UITableView+Helper.h"

@implementation UITableView (Helper)

- (void)registerNibWithClass:(Class)nibClass{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(nibClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(nibClass)];
}

@end
