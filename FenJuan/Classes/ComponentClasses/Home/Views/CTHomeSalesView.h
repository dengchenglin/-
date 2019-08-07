//
//  CTHomeSalesView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTHomeModel.h"

@interface CTHomeSalesView : UIView
@property (weak, nonatomic) IBOutlet UIView *titleheadView;
@property (weak, nonatomic) IBOutlet UIView *goodsView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, copy) void (^clickItemBlock)(NSInteger index);

@property (nonatomic, strong) CTHomeHotGoodsModel *model;

@end