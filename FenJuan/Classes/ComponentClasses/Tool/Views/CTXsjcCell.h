//
//  CTXsjcCell.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/10.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPlayerButton.h"

#import "CTSxyModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol  CTXsjcCellDelegate <NSObject>
- (void)didClickVideoWithIndexPath:(NSIndexPath *)indexPath;
@end

@interface CTXsjcCell : UITableViewCell
@property (nonatomic, assign) NSInteger howmuch;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *closegelaozi;
@property (nonatomic, copy) NSString *numberonen;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet CTPlayerButton *playButton;
@property (nonatomic, strong) CTSxyModel *model;

@property (nonatomic, weak) id <CTXsjcCellDelegate>delegate;
@property (nonatomic, copy) NSIndexPath *indexPath;
- (void)stopPlay;
- (void)removeVideoView;
@end

NS_ASSUME_NONNULL_END
