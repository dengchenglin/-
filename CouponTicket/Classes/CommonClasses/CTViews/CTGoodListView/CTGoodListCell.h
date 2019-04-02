//
//  CTGoodListCell.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTGoodListView_.h"

@interface CTGoodListCell : UITableViewCell

@property (nonatomic, strong) CTGoodListView_ *containerView;

@property (nonatomic, strong) CTGoodsViewModel *viewModel;

@property (nonatomic, strong) CTGoodsModel *model;
@end
