//
//  CTHomeSpreeShopView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTHomeModel.h"

@interface CTHomeSpreeShopView : UIView

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIView *goodsView;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextTimeLabel;

@property (nonatomic, copy) void (^clickItemBlock)(NSInteger index);

@property (nonatomic, strong) CTHomeCurTimeBuyModel *model;

@end
