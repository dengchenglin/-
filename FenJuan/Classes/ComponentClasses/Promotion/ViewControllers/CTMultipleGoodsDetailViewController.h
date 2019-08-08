//
//  CTMultipleGoodsDetailViewController.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMultipleGoodsDetailViewController : CTBaseListViewController
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;

@property (nonatomic, copy) NSArray <CTGoodsModel *> *datas;
@end

NS_ASSUME_NONNULL_END
