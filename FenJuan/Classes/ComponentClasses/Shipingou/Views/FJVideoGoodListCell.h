//
//  CTVideoGoodListCell.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTGoodListView_.h"

#import "CTPlayerButton.h"

@protocol CTVideoGoodListCellDelegate<NSObject>

- (void)didClickVideoWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface CTVideoGoodListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UIView *profitView;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;



@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet CTPlayerButton *playButton;


@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@property (nonatomic, strong) CTGoodsModel *model;
@property (nonatomic, weak) id <CTVideoGoodListCellDelegate>delegate;
@property (nonatomic, copy) NSIndexPath *indexPath;
- (void)stopPlay;
- (void)removeVideoView;
@end
