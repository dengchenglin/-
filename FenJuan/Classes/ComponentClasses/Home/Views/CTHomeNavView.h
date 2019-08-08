//
//  CTHomeNavView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTActivityModel.h"

@interface CTHomeNavView : UIView
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, copy) NSArray <CTActivityModel *> *activitys;

@property (nonatomic, copy) void (^clickItemBlock)(CTActivityModel *model);

@end
