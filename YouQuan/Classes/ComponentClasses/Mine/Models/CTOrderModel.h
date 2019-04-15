//
//  CTOrderModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/20.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTOrderModel : NSObject

@property (nonatomic, copy) NSString *alipay_total_price;
@property (nonatomic, assign) NSInteger tk_status;
@property (nonatomic, copy) NSString *trade_id;
@property (nonatomic, copy) NSString *item_title;
@property (nonatomic, copy) NSString *item_img;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *tk_status_txt;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *headimg;

@end
