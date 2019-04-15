//
//  CTTableView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTTableView.h"

@implementation CTTableView

- (void)registerNibWithClass:(Class)_class{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(_class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(_class)];
}

- (__kindof UITableViewCell *)cellForIdentigier:(NSString *)identifier{
    UITableViewCell *cell = objc_getAssociatedObject(self, &identifier);
    if(!cell){
        cell = [self dequeueReusableCellWithIdentifier:identifier];
        objc_setAssociatedObject(self, &identifier, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cell;
}
@end
