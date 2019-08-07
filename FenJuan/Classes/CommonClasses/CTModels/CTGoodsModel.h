//
//  CTGoodModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTGoodDefine.h"

#import "CTGlobalConst.h"

NSString *GetGoodsOrderStr(CTGoodSortType type);

NSString *GetTypeImageStr(NSInteger status);

NSString *GetGrabTypeStr(NSInteger type);

@interface CTSeckillContentModel:NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *text;
@end


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

//快抢
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, assign) NSInteger grab_type;
@property (nonatomic, copy) NSString *main_video_cover;
@property (nonatomic, copy) NSString *main_video_url;
@property (nonatomic, copy) NSString *start_time_txt;
@property (nonatomic, copy) NSArray <CTSeckillContentModel *> *seckill_content;

//发圈

@property (nonatomic, copy) NSString *commission_rate;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSArray <NSString *> *itempics;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *show_content;
@property (nonatomic, copy) NSString *cpy_content;
@property (nonatomic, copy) NSArray <NSString *>*comments;
@property (nonatomic, copy) NSArray <NSString *>*cpy_comments;
@property (nonatomic, copy) NSArray <NSString *>*show_comments;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *app_name;
@property (nonatomic, copy) NSString *app_logo;

//分享
@property (nonatomic, copy) NSString *order_url;
@property (nonatomic, copy) NSString *iv_code;
@property (nonatomic, copy) NSString *tpwd;
@property (nonatomic, copy) NSString *qr_create_url;

@property (nonatomic, assign) BOOL imgAnimated;
@property (nonatomic, copy) UIImage *image;

@property (nonatomic, copy) NSArray<CTGoodsModel*> *item_data;

//新人专享相关
@property (nonatomic, copy) NSString *price_desc;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CTShopKind shopKind;



@end
