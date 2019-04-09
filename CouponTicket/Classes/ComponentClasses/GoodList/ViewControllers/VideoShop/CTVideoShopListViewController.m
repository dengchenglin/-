//
//  CTVideoShopListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTVideoShopListViewController.h"

#import "CTGoodSortView.h"

#import "CTVideoGoodListCell.h"

#import "CTNetworkEngine+Recommend.h"

#import <JPVideoPlayer/UIView+WebVideoCache.h>

@interface CTVideoShopListViewController ()<CTVideoGoodListCellDelegate,JPVideoPlayerDelegate>

@property (nonatomic, strong) CTGoodSortView *sortView;

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@property (nonatomic, copy) NSIndexPath *currentIndexPath;

@end

@implementation CTVideoShopListViewController

@synthesize dataSources = _dataSources;

- (CTGoodSortView *)sortView{
    if(!_sortView){
        _sortView = [[CTGoodSortView alloc]init];
        _sortView.backgroundColor = [UIColor whiteColor];
    }
    return _sortView;
}

- (void)setUpUI{
    [self.view addSubview:self.sortView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNibWithClass:CTVideoGoodListCell.class];
}

- (void)autoLayout{
    [self.sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sortView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.sortView setClickBlock:^(CTGoodSortType type) {
        @strongify(self)
        self.pageIndex = 1;
        self.isLoadMore = NO;
        [self.dataSources removeAllObjects];
        [self.tableView reloadData];
        [self request];
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self pauseVideo];
}

- (void)request{
    [[JPVideoPlayerManager sharedManager]stopPlay];
    _currentIndexPath = nil;
    [CTRequest videoBuyGoodsWithPage:self.pageIndex size:self.pageSize cateId:self.cateId order:GetGoodsOrderStr(self.sortView.currentType) callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTGoodsModel.class viewModelClass:CTGoodsViewModel.class];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 292;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTVideoGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTVideoGoodListCell.class)];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.viewModel = self.dataSources[indexPath.row];
    if(!_currentIndexPath){
        if(!cell.viewModel.isPlay){
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] goodDetailViewControllerWithGoodId:self.dataSources[indexPath.row].model.uid];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CTVideoGoodListCellDelegate
//触发播放
- (void)didClickVideoWithIndexPath:(NSIndexPath *)indexPath{
    [self removeCurrentVideo];//先停止当前播放的cell
    _currentIndexPath = indexPath;
    CTVideoGoodListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.playButton.jp_videoPlayerDelegate = self;
    NSString *video = self.dataSources[indexPath.row].model.video;
    [cell.playButton jp_playVideoWithURL:[NSURL URLWithString:video] bufferingIndicator:nil controlView:nil progressView:nil configuration:nil];
   
    //防止cell状态被重用，事先还原所有未播放cell的状态
    NSArray <CTVideoGoodListCell *>*cells = [self.tableView visibleCells];
    for(CTVideoGoodListCell *cell in cells){
        if(![cell.indexPath isEqual:_currentIndexPath]){
            [cell removeVideoView];
        }
    }
}

//滑动过程中检测cell是否有被回收 如果有则停止所有播放
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!_currentIndexPath)return;//如果没有任何播放的视频直接返回
    NSArray <CTVideoGoodListCell *>*cells = [self.tableView visibleCells];
    if(!cells.count)return;
    
    BOOL isPlayingCellVisiable = NO;//正在播放视频的cell是否可见
    for(CTVideoGoodListCell *cell in cells){
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
    NSArray <CTVideoGoodListCell *>*cells = [self.tableView visibleCells];
    for(CTVideoGoodListCell *cell in cells){
        [cell stopPlay];
    }
    _currentIndexPath = nil;
    for(CTGoodsViewModel *viewModel in self.dataSources){
        viewModel.isPlay = NO;
    }
}

//还原播放cell的状态 (内部因素导致播放停止时需要调用)
- (void)resetAllVideoCellStatus{
    NSArray <CTVideoGoodListCell *>*cells = [self.tableView visibleCells];
    for(CTVideoGoodListCell *cell in cells){
        [cell removeVideoView];
    }
    for(CTGoodsViewModel *viewModel in self.dataSources){
        viewModel.isPlay = NO;
    }
}
//停止当前播放的cell
- (void)removeCurrentVideo{
    if(_currentIndexPath){
        CTVideoGoodListCell *cell = [self.tableView cellForRowAtIndexPath:_currentIndexPath];
        [cell stopPlay];
    }
}

//暂停当前播放的cell
- (void)pauseVideo{
    if(_currentIndexPath){
         CTVideoGoodListCell *cell = [self.tableView cellForRowAtIndexPath:_currentIndexPath];
        [cell.playButton jp_pause];
    }
}

//播放器内部因素导致播放停止（网络错误，音频出错，播放结束等）
- (void)playerStatusDidChanged:(JPVideoPlayerStatus)playerStatus{
    CTVideoGoodListCell *cell;
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

@end
