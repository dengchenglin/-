//
//  CTSearchTicketViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

#import "CTCategoryModel.h"

@interface CTSearchTicketViewModel : CTViewModel

@property (nonatomic, copy) NSArray <CTCategoryModel *>*categoryModels;

@end