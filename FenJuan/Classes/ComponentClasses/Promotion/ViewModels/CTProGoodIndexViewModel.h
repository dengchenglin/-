//
//  CTOneGoodIndexViewModel.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTViewModel.h"
#import "CTGoodsModel.h"
#import "CTPicturesView.h"
NS_ASSUME_NONNULL_BEGIN
#define CTProGoodIndexUserHeight             72
#define CTProGoodIndexContentWidth           (SCREEN_WIDTH - 30)
#define CTProGoodIndexPictureRow             3
#define CTProGoodIndexPictureLineSpace       10
#define CTProGoodIndexPictureItemSpace       10
#define CTProGoodIndexPictureInsets          UIEdgeInsetsMake(10, 0, 10, 0)
#define CTProGoodIndexPictureWidth           (SCREEN_WIDTH - 30)
#define CTProGoodIndexCommentHeight          45
#define CTProGoodIndexCommentSpace           12
#define CTProGoodIndexCommentWidth           (SCREEN_WIDTH - 30)
@interface CTProGoodIndexViewModel : CTViewModel
@property (nonatomic, strong) CTGoodsModel *model;
@property (nonatomic, copy) NSAttributedString *content;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, copy) NSArray <CTPictureModel *> *imgModels;
@property (nonatomic, assign) CGFloat imgViewHeight;
@property (nonatomic, assign) CGFloat commentViewHeight;
@property (nonatomic, assign) CGFloat onGoodCellHeight;
@property (nonatomic, assign) CGFloat multipleGoodsCellHeight;
@end

NS_ASSUME_NONNULL_END
