//
//  CTGoodModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTGoodsModel : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *sale_price;

@property (nonatomic, copy) NSString *goods_title;

@property (nonatomic, copy) NSString *goods_short_title;

@property (nonatomic, copy) NSString *goods_logo;

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *coupon_amount;

@property (nonatomic, copy) NSString *commission_money;

@property (nonatomic, copy) NSString *coupon_price;

@property (nonatomic, copy) NSString *upgrade_money;

@property (nonatomic, copy) NSString *type_logo;

@property (nonatomic, copy) NSString *item_id;
@end
