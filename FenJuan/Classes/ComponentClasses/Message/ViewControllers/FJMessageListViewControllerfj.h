//
//  CTMessageListViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseListViewController.h"

#import "CTNetworkEngine+Message.h"

@interface FJMessageListViewControllerfj : CTBaseListViewController

@property (nonatomic, assign) CTMessageType messageType;

@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@end