//
//  CTVideoGoodListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJVideoGoodListCellfj.h"
#import <JPVideoPlayer/UIView+WebVideoCache.h>
@implementation FJVideoGoodListCellfj

- (void)awakeFromNib {
    [super awakeFromNib];
     _goodView = NSMainBundleClass(CTGoodListView_.class);
    [self.goodBackView addSubview:_goodView];
    [_goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    @weakify(self)
    [self.playButton touchUpInsideSubscribeNext:^(UIButton *x) {
        @strongify(self)
        if(self.delegate && [self.delegate respondsToSelector:@selector(didClickVideoWithIndexPath:)]){
            [self.delegate didClickVideoWithIndexPath:self.indexPath];
        }
    }];
}

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    [_previewImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.video_img]];
    _goodView.viewModel = _viewModel;
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
