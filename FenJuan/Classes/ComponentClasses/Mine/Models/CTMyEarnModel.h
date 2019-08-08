//
//  CTMyEarnModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CTEarnInfo:NSObject
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *order_num;
@property (nonatomic, copy) NSString *title;
@end
@interface CTMyEarnModel : UIView
@property (nonatomic, copy) NSString *today_money;
@property (nonatomic, copy) NSString *month_money;
@property (nonatomic, copy) NSString *all_money;
@property (nonatomic, copy) NSString *sl_today_money;
@property (nonatomic, copy) NSString *sl_month_money;
@property (nonatomic, copy) NSString *valuation_money;
@property (nonatomic, copy) NSString *lm_money;
@property (nonatomic, copy) NSString *sl_lm_money;

@property (nonatomic, copy) NSString *lm_all_money;
@property (nonatomic, strong) CTEarnInfo *today;
@property (nonatomic, strong) CTEarnInfo *yesterday;
@property (nonatomic, strong) CTEarnInfo *month;
@property (nonatomic, strong) CTEarnInfo *last_month;
@property (nonatomic, copy) NSString *trend_chart_url;


@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@end
