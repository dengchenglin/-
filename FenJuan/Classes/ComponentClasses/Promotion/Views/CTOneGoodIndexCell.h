//
//  CTOneGoodIndexCell.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPicturesView.h"
#import "CTProCommentView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol CTOneGoodIndexCellDelegate <NSObject>

- (void)didShareWithIndex:(NSInteger)index;

@end

@interface CTOneGoodIndexCell : UITableViewCell
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;


@property (weak, nonatomic) IBOutlet UIImageView *userLogo;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButton;
@property (weak, nonatomic) IBOutlet CTPicturesView *picturesView;
@property (weak, nonatomic) IBOutlet CTProCommentView *commentsView;
@property (weak, nonatomic) IBOutlet UIButton *cpyButton;
@property (nonatomic, strong) CTProGoodIndexViewModel *viewModel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<CTOneGoodIndexCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
