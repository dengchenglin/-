//
//  CTSxySpjxViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSxySpjxViewController.h"
#import "CTNetworkEngine+Rich.h"

#import "CTXsjcCell.h"

#import "CTSxyModel.h"

#import <JPVideoPlayer/UIView+WebVideoCache.h>
@interface CTSxySpjxViewController ()<CTXsjcCellDelegate,JPVideoPlayerDelegate>
@property (nonatomic, strong) NSMutableArray <CTSxyModel *>*dataSources;
@property (nonatomic, copy) NSIndexPath *currentIndexPath;

@end

@implementation CTSxySpjxViewController

@synthesize dataSources = _dataSources;

- (void)setUpUI{
    self.title = @"视频教程";
    self.navigationBarStyle = CTNavigationBarWhite;
    self.canLoadMore = NO;
    [self.tableView registerNibWithClass:CTXsjcCell.class];
}
- (void)request{
    [CTRequest businessSchoolListWithType:CTSxy_spjc callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTSxyModel.class viewModelClass:nil];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTXsjcCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTXsjcCell.class)];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = self.dataSources[indexPath.row];
    if(!_currentIndexPath){
        if(!cell.model.isPlay){
            [cell stopPlay];
        }
    }
    else{
        if(![indexPath isEqual:_currentIndexPath]){
            [cell removeVideoView];
        }
    }
    return cell;
}

#pragma mark - CTVideoGoodListCellDelegate
//触发播放
- (void)didClickVideoWithIndexPath:(NSIndexPath *)indexPath{
    [self removeCurrentVideo];//先停止当前播放的cell
    _currentIndexPath = indexPath;
    CTXsjcCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.playButton.selected = YES;
    cell.playButton.jp_videoPlayerDelegate = self;
    NSString *video = self.dataSources[indexPath.row].video_url;
    [cell.playButton jp_playVideoWithURL:[NSURL URLWithString:video] bufferingIndicator:nil controlView:nil progressView:nil configuration:nil];
    
    //防止cell状态被重用，事先还原所有未播放cell的状态
    NSArray <CTXsjcCell *>*cells = [self.tableView visibleCells];
    for(CTXsjcCell *cell in cells){
        if(![cell.indexPath isEqual:_currentIndexPath]){
            [cell removeVideoView];
        }
    }
}


//滑动过程中检测正在播放cell是否有被回收 如果有则停止所有播放
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!_currentIndexPath)return;//如果没有任何播放的视频直接返回
    NSArray <CTXsjcCell *>*cells = [self.tableView visibleCells];
    if(!cells.count)return;
    
    BOOL isPlayingCellVisiable = NO;//正在播放视频的cell是否可见
    for(CTXsjcCell *cell in cells){
        if([cell.indexPath isEqual:_currentIndexPath]){
            isPlayingCellVisiable = YES;
        }
    }
    if(!isPlayingCellVisiable){
        //如果不可见 停止播放器
        //还原播放视图的状态并删除对应的播放器View
        NSLog(@"播放的cell被回收了.....");
        [self stopAllVideoCell];
        
    }
}
//停止所有播放cell （手动调用）
- (void)stopAllVideoCell{
    NSArray <CTXsjcCell *>*cells = [self.tableView visibleCells];
    for(CTXsjcCell *cell in cells){
        [cell stopPlay];
    }
    _currentIndexPath = nil;
    for(CTGoodsViewModel *viewModel in self.dataSources){
        viewModel.isPlay = NO;
    }
}

//还原播放cell的状态 (内部因素导致播放停止时需要调用)
- (void)resetAllVideoCellStatus{
    NSArray <CTXsjcCell *>*cells = [self.tableView visibleCells];
    for(CTXsjcCell *cell in cells){
        [cell removeVideoView];
    }
    for(CTGoodsViewModel *viewModel in self.dataSources){
        viewModel.isPlay = NO;
    }
}
//停止当前播放的cell
- (void)removeCurrentVideo{
    if(_currentIndexPath){
        CTXsjcCell *cell = [self.tableView cellForRowAtIndexPath:_currentIndexPath];
        [cell stopPlay];
    }
}

//暂停当前播放的cell
- (void)pauseVideo{
    if(_currentIndexPath){
        CTXsjcCell *cell = [self.tableView cellForRowAtIndexPath:_currentIndexPath];
        [cell.playButton jp_pause];
        cell.playButton.jp_controlView.superview.alpha = 1.0;
    }
}

//播放器内部因素导致播放停止（网络错误，音频出错，播放结束等）
- (void)playerStatusDidChanged:(JPVideoPlayerStatus)playerStatus{
    CTXsjcCell *cell;
    if(_currentIndexPath){
        cell = [self.tableView cellForRowAtIndexPath:_currentIndexPath];
        
    }
    if(playerStatus == JPVideoPlayerStatusStop){
        [cell.playButton jp_gotoPortrait];
        [self resetAllVideoCellStatus];
    }
    if(playerStatus == JPVideoPlayerStatusPlaying){
        cell.playButton.selected = YES;
    }
}
- (BOOL)shouldAutoReplayForURL:(NSURL *)videoURL{
    return NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self pauseVideo];
}

- (void)dealloc
{
    [self removeCurrentVideo];
}




@end
