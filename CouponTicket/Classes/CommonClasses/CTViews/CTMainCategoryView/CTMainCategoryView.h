//
//  CTMainCategoryView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/20.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTCategoryModel.h"

#import "CTMainCategoryItem.h"

@interface CTMainCategoryView : UIView

@property (nonatomic, copy) NSArray <CTCategoryModel *> *categoryModels;

@property (nonatomic, copy) void(^clickItemBlock)(NSInteger index);

+ (CGFloat)heightForCategoryCount:(NSInteger)count;

@end
