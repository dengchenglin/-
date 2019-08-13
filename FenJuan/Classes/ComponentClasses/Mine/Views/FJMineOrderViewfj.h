//
//  CTMineOrderView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJMineOrderViewfj : UIView
@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@property (weak, nonatomic) IBOutlet UIView *lookMoreView;
@property (weak, nonatomic) IBOutlet UIView *payedView;
@property (weak, nonatomic) IBOutlet UIView *calculatedView;
@property (weak, nonatomic) IBOutlet UIView *disabledView;
@property (weak, nonatomic) IBOutlet UIView *refundView;

@end
