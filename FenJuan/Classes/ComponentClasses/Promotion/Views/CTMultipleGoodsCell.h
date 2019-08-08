//
//  CTMultipleGoodsCell.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPicturesView.h"
#import "CTProGoodIndexViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CTMultipleGoodsCellDelegate <NSObject>

- (void)didShareWithIndex:(NSInteger)index;

- (void)didClickWithModel:(CTGoodsModel *)model;

@end
@interface CTMultipleGoodsCell : UITableViewCell
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;


@property (weak, nonatomic) IBOutlet UIImageView *userLogo;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *cpyButton;
@property (weak, nonatomic) IBOutlet CTPicturesView *picturesView;

@property (nonatomic, strong) CTProGoodIndexViewModel *viewModel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<CTMultipleGoodsCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
