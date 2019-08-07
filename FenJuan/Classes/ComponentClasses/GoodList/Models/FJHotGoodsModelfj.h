//
//  CTHotGoodsModel.h
//  CouponTicket
//
//  Created by Dankal on 2019/3/16.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJHotGoodsModelfj : NSObject
@property (nonatomic, assign) double update_timestamp;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, assign) double next_update_timestamp;
@property (nonatomic, copy) NSString *next_update_time;
@property (nonatomic, copy) NSString *update_text;
@property (nonatomic, copy) NSArray *goods;
@end
