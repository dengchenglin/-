//
//  CTJdpListCell.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTJdpIndexModel.h"

NS_ASSUME_NONNULL_BEGIN

#define CTJdpListCellHeight 280

@protocol CTJdpListCellDelegate <NSObject>

- (void)didClickMoreWithIndex:(NSInteger)index;

- (void)didClickItemWithModel:(CTGoodsModel *)model;
@end

@interface CTJdpListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;

@property (weak, nonatomic) IBOutlet UIView *lookMoreButton;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<CTJdpListCellDelegate>delegate;
@property (nonatomic, strong) CTJdpIndexModel *model;

@end

NS_ASSUME_NONNULL_END
