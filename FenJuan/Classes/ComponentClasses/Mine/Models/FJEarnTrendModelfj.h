//
//  CTEarnTrendModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTEarnIndexModel.h"
@interface FJEarnTrendModelfj : NSObject
@property (nonatomic, copy) NSArray <CTEarnIndexModel *> *day30_lists;
@property (nonatomic, copy) NSString *day30_money;
@property (nonatomic, copy) NSString *trend_chart_url;

@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@end