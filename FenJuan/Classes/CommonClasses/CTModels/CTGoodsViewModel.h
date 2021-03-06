//
//  CTGoodsViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

#import "CTGoodsModel.h"

@interface CTGoodsViewModel : CTViewModel
@property (nonatomic, strong) CTGoodsModel *model;
@property (nonatomic, assign) BOOL isPlay;
+ (NSString *)reconstructionHtml5:(NSString *)html5;
@end
