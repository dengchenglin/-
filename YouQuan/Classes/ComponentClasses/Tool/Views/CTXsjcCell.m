//
//  CTXsjcCell.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/10.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTXsjcCell.h"
#import <JPVideoPlayer/UIView+WebVideoCache.h>
@implementation CTXsjcCell
- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [self.playButton touchUpInsideSubscribeNext:^(UIButton *x) {
        @strongify(self)
        if(self.delegate && [self.delegate respondsToSelector:@selector(didClickVideoWithIndexPath:)]){
            [self.delegate didClickVideoWithIndexPath:self.indexPath];
        }
    }];
}

- (void)setModel:(CTSxyModel *)model{
    _model = model;
    [_previewImageView sd_setImageWithURL:[NSURL URLWithString:_model.img]];
}

- (void)stopPlay{
    [self.playButton jp_stopPlay];
    self.playButton.selected = NO;
    if(self.playButton.jp_videoPlayerView.superview){
        [self.playButton.jp_videoPlayerView removeFromSuperview];
    }
}
- (void)removeVideoView{
    self.playButton.selected = NO;
    if(self.playButton.jp_videoPlayerView.superview){
        [self.playButton.jp_videoPlayerView removeFromSuperview];
    }
}
@end
