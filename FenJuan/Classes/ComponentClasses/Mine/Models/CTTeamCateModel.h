//
//  CTTeamCateModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTTeamCateItem: NSObject
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, copy) NSString *txt;

@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@end

@interface CTTeamCateModel : NSObject
@property (nonatomic, strong) CTTeamCateItem *all;
@property (nonatomic, strong) CTTeamCateItem *directly;
@property (nonatomic, strong) CTTeamCateItem *indirect;
@end
