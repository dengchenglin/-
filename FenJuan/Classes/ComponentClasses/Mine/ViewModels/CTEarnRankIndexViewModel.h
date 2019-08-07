//
//  CTEarnRankIndexViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

@interface CTEarnRankIndexViewModel : CTViewModel
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, copy) UIImage *rankImage;
@property (nonatomic, assign) BOOL showRankImage;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *headimg;

@end
