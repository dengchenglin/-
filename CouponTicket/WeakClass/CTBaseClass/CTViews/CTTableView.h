//
//  CTTableView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTableView : UITableView

- (void)registerNibWithClass:(Class)_class;
//优化算高
- (__kindof UITableViewCell *)cellForIdentigier:(NSString *)identifier;


@end
