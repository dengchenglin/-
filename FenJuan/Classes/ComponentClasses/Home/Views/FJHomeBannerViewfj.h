//
//  CTHomeBannerView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJHomeBannerViewfj : UIView

@property (nonatomic, copy) void (^clickItemBlock)(NSInteger index);

@property (nonatomic, copy) NSArray <NSString *> *banner_imgs;

@end
