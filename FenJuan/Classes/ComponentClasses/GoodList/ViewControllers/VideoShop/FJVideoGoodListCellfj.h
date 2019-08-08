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

@interface FJVideoGoodListCellfj : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet CTPlayerButton *playButton;
@property (weak, nonatomic) IBOutlet UIView *goodBackView;

@property (nonatomic, strong) CTGoodListView_ *goodView;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@property (nonatomic, weak) id <CTVideoGoodListCellDelegate>delegate;
@property (nonatomic, copy) NSIndexPath *indexPath;
- (void)stopPlay;
- (void)removeVideoView;
@end
