//
//  CTHomeSpreeShopView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTHomeSpreeShopView : UIView

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIView *goodsView;

@property (nonatomic, copy) void (^clickItemBlock)(NSInteger index);

@property (nonatomic, copy) NSArray *goods;

@end
