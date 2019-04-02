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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self resumeVideo];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self pauseVideo];
}

- (void)request{
    [[JPVideoPlayerManager sharedManager]stopPlay];
    _currentIndexPath = nil;
    [CTRequest videoBuyGoodsWithPage:self.pageIndex size:self.pageSize cateId:self.cateId order:GetGoodsOrderStr(self.sortView.currentType) callback:^(id data, CLRequest *request, CTNetError error) {
        [self.tableView endRefreshing];
//        [self analysisAndReloadWithData:data error:error modelClass:CTGoodsModel.class viewModelClass:CTGoodsViewModel.class];
   
        for(int i = 0;i < 20;i ++){
            [self.dataSources addObject:[CTGoodsViewModel new]];
        }
        [self.tableView reloadData];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] goodDetailViewControllerWithGoodId:self.dataSources[indexPath.row].model.uid];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CTVideoGoodListCellDelegate
- (void)didClickVideoWithIndexPath:(NSIndexPath *)indexPath{
    _currentIndexPath = indexPath;
    CTVideoGoodListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.playButton.selected = YES;
    [cell.playButton jp_playVideoWithURL:[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]bufferingIndicator:nil controlView:nil progressView:nil configuration:nil];
    cell.playButton.jp_videoPlayerDelegate = self;
    NSArray <CTVideoGoodListCell *>*cells = [self.tableView visibleCells];
    for(CTVideoGoodListCell *cell in cells){
        if(![cell.indexPath isEqual:_currentIndexPath]){
            [cell removeVideoView];
        }
    }
}

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
        [self removeAllVideoCell];
       
    }
}
- (void)removeAllVideoCell{
    NSArray <CTVideoGoodListCell *>*cells = [self.tableView visibleCells];
    for(CTVideoGoodListCell *cell in cells){
        [cell stopPlay];
    }
    _currentIndexPath = nil;
    for(CTGoodsViewModel *viewModel in self.dataSources){
        viewModel.isPlay = NO;
    }
}

- (void)resumeVideo{
    for(int i = 0;i < self.dataSources.count;i ++){
        CTGoodsViewModel *viewModel = self.dataSources[i];
        if(viewModel.isPlay){
            CTVideoGoodListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell.playButton jp_resume];
        }
    }
}
- (void)pauseVideo{
    for(int i = 0;i < self.dataSources.count;i ++){
        CTGoodsViewModel *viewModel = self.dataSources[i];
        if(viewModel.isPlay){
            CTVideoGoodListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell.playButton jp_pause];
        }
    }
}


- (void)playerStatusDidChanged:(JPVideoPlayerStatus)playerStatus{
    if(playerStatus == JPVideoPlayerStatusStop){
        [self removeAllVideoCell];
    }
}
- (void)playVideoFailWithError:(NSError *)error
                      videoURL:(NSURL *)videoURL{
    NSLog(@"%@",error);
}
@end
