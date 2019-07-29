//
//  CTCateMainListView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTCateMainListView : UIView

@property (nonatomic, strong) NSArray <CTCategoryModel *>*datas;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) void (^indexChangedBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
