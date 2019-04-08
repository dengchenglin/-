//
//  CTEarnRankModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTEarnRankIndexModel:NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *headimg;
@end

@interface CTEarnRankModel : NSObject
@property (nonatomic, copy) NSArray <CTEarnRankIndexModel *> *yesterday;
@property (nonatomic, copy) NSArray <CTEarnRankIndexModel *> *month;
@property (nonatomic, copy) NSArray <CTEarnRankIndexModel *> *last_month;
@property (nonatomic, copy) NSArray <CTEarnRankIndexModel *> *all;
@end
