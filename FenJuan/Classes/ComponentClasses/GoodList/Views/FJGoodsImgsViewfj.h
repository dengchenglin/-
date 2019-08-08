//
//  CTGoodsImgsView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJGoodsImgsViewfj : UIView

@property (nonatomic, copy) void (^clickItemBlock)(NSInteger index);

@property (nonatomic, copy) NSArray <NSString *> *banner_imgs;


@end
