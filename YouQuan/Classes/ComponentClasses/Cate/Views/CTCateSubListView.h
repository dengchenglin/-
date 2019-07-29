//
//  CTCateSubListView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

#define CTCateSubListViewWidth (SCREEN_WIDTH - 78)

#define CTCateSubListCellSize CGSizeMake(CTCateSubListViewWidth/3,120)
@interface CTCateSubListView : UIView

@property (nonatomic, copy) NSArray <CTCategoryModel *>*datas;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) void (^indexChangedBlock)(NSInteger index);

@property (nonatomic, strong) CTCategoryModel *model;

@end

NS_ASSUME_NONNULL_END
