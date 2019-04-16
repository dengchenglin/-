//
//  CTGoodModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTGoodDefine.h"

NSString *GetGoodsOrderStr(CTGoodSortType type);

NSString *GetTypeImageStr(NSInteger status);

@interface CTGoodsModel : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *sale_price;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *goods_short_title;
@property (nonatomic, copy) NSString *goods_content;
@property (nonatomic, copy) NSString *goods_content_url;
@property (nonatomic, copy) NSString *goods_rich_url;
@property (nonatomic, copy) NSString *goods_logo;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *coupon_amount;
@property (nonatomic, copy) NSString *coupon_text;
@property (nonatomic, copy) NSString *commission_money;
@property (nonatomic, copy) NSString *coupon_price;
@property (nonatomic, copy) NSString *upgrade_money;
@property (nonatomic, copy) NSString *type_logo;
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *shop_title;
@property (nonatomic, copy) NSArray <NSString *> *goods_image;
@property (nonatomic, copy) NSString *marke_id;
@property (nonatomic, copy) NSString *marke_type;
@property (nonatomic, copy) NSString *goods_desc;
@property (nonatomic, copy) NSString *package_stock;
@property (nonatomic, copy) NSString *package_sale;
@property (nonatomic, assign) NSInteger favorite_num;
@property (nonatomic, assign) BOOL is_favorite;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *shop_url;
@property (nonatomic, copy) NSString *coupon_end_time;
@property (nonatomic, copy) NSString *coupon_share_url;
@property (nonatomic, assign) BOOL show_coupon;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSArray<NSString *> *imgs;
@property (nonatomic, copy) NSArray <CTGoodsModel*> *goods;

@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *video_img;
@end