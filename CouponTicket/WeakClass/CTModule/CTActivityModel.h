//
//  CTActivityModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CTLinkType) {
    CTLinkWeb = 1,
    CTLinkGoodsDetail
};

@interface CTActivityModel : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *href;

@property (nonatomic, assign) CTLinkType link_type;

@end
