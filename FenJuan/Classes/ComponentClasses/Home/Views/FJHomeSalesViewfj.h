//
//  CTHomeSalesView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FJHomeModelfj.h"

@interface FJHomeSalesViewfj : UIView
@property (weak, nonatomic) IBOutlet UIView *titleheadView;
@property (weak, nonatomic) IBOutlet UIView *goodsView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, copy) void (^clickItemBlock)(NSInteger index);

@property (nonatomic, strong) CTHomeHotGoodsModel *model;
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@end
