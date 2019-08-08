//
//  CTSearchTicketViewModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"

#import "CTCategoryModel.h"

#import "CTGoodsViewModel.h"

@interface CTSearchTicketViewModel : CTViewModel
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;

@property (nonatomic, copy) NSArray <CTCategoryModel *>*categoryModels;

@property (nonatomic, copy) NSArray <CTGoodsViewModel *> *likes;

@end
