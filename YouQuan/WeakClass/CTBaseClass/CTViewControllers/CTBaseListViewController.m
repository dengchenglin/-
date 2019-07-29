//
//  CTBaseListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseListViewController.h"

#import "UIScrollView+CLRefresh.h"

#import "LineLayout.h"

@interface CTBaseListViewController ()

@property (nonatomic, weak, readonly) UIScrollView *listScrollView;

@property (nonatomic, strong) UIButton *goTopButton;

@end

@implementation CTBaseListViewController

- (void)initialize{
    self.pageIndex = 1;
    self.pageSize = 20;
    self.canRefresh = YES;
    self.canLoadMore = YES;
    self.dataSources = [NSMutableArray array];
}

- (CTTableView *)tableView{
    if(!_tableView && !self.isCollectionView){
        _tableView = [[CTTableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (UICollectionView *)collectionView{
    if(!_collectionView && self.isCollectionView){
        LineLayout *layout = [[LineLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

- (UIScrollView *)listScrollView{
    return self.isCollectionView?self.collectionView:self.tableView;
}

- (UIButton *)goTopButton{
    if(!_goTopButton){
        _goTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goTopButton setImage:[UIImage imageNamed:@"pic_home_gotop"] forState:UIControlStateNormal];
        _goTopButton.alpha = 0;
        
    }
    return _goTopButton;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        @weakify(self)
        //回到顶部
        [self.view addSubview:self.goTopButton];
        [self.goTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            CGFloat bottom = -50;
            if(self.navigationController.viewControllers.count < 2){
                bottom = -15;
            }
            make.right.mas_equalTo(-20);
            make.width.height.mas_equalTo(50);
            make.bottom.mas_equalTo(bottom);
            
        }];
        [self.goTopButton touchUpInsideSubscribeNext:^(id x) {
            @strongify(self)
            [self.listScrollView setContentOffset:CGPointZero animated:YES];
        }];
        
        [RACObserve(self.listScrollView, contentOffset) subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            CGPoint contentOffset = [x CGPointValue];
            //根据偏移判断是否现在回到顶部按钮(两个屏幕高度)
            if(contentOffset.y > SCREEN_HEIGHT * 2){
                if(self.goTopButton.alpha != 1.0){
                    [UIView animateWithDuration:0.3 animations:^{
                        self.goTopButton.alpha = 1.0;
                    }];
                }
            }
            else {
                if(self.goTopButton.alpha != 0.0){
                    [UIView animateWithDuration:0.3 animations:^{
                        self.goTopButton.alpha = 0.0;
                    }];
                }
            }
        }];
        if(self.canRefresh){
            [self.listScrollView addHeaderRefreshWithCallBack:^{
                @strongify(self)
                self.pageIndex = 1;
                self.isLoadMore = NO;
                self.minId = nil;
                [self request];
            }];
        }
        if(self.canLoadMore){
            [self.listScrollView addFooterRefreshWithCallBack:^{
                @strongify(self)
                self.pageIndex += 1;
                self.isLoadMore = YES;
                [self request];
            }];
        }
    });
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.goTopButton];
}

- (void)analysisAndReloadWithData:(NSArray *)data error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass{
    [self analysisAndReloadWithData:data error:error modelClass:modelClass viewModelClass:viewModelClass completed:nil];
}

- (void)analysisAndReloadWithData:(id)data listKey:(NSString *)listKey error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass{
    [self analysisAndReloadWithData:data listKey:listKey error:error modelClass:modelClass viewModelClass:viewModelClass completed:nil];
}
- (void)analysisAndReloadWithData:(id)data listKey:(NSString *)listKey error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass completed:(void(^)(void))completed{
    if([data isKindOfClass:NSArray.class]){
        [self analysisAndReloadWithData:data error:error modelClass:modelClass viewModelClass:viewModelClass completed:completed];
    }
    else{
        __block id arr;
        if(!error){
            NSArray *keys = [listKey componentsSeparatedByString:@"/"];
            __block id tempData = data;
            [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                arr = tempData[keys[idx]];
                tempData = arr;
            }];
        }
        self.minId = data[@"min_id"];
        [self analysisAndReloadWithData:arr error:error modelClass:modelClass viewModelClass:viewModelClass completed:completed];
    }
}


- (void)analysisAndReloadWithData:(NSArray *)data error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass completed:(void (^)(void))completed{
    
    [self.listScrollView endRefreshing];
    [LMDataResultView hideDataResultOnView:self.view];
    [LMDataResultView hideDataResultOnView:self.listScrollView];
    if(!error){
        if(!self.isLoadMore){
            [self.dataSources removeAllObjects];
        }
        NSArray *models = [modelClass yy_modelsWithDatas:data];
        for(int i = 0;i < models.count;i ++){
            if(viewModelClass){
                [self.dataSources addObject:[viewModelClass bindModel:models[i]]];
            }
            else{
                [self.dataSources addObject:models[i]];
            }
        }
        [self reloadData];
        
        
        if(self.minId){
            if(data.count == 0){
                [self.listScrollView showNulMoreView];
            }
            else{
                [self.listScrollView hiddenNulMoreView];
            }
        }
        else{
            if(data.count < self.pageSize){
                [self.listScrollView showNulMoreView];
            }
            else{
                [self.listScrollView hiddenNulMoreView];
            }
        }
        
        if(!self.isLoadMore && self.dataSources.count == 0){
            [LMDataResultView showNoDataResultOnView:self.listScrollView];
        }
        else{
            [LMDataResultView hideDataResultOnView:self.listScrollView];
        }
    }
    else{
        if(self.isLoadMore){
            self.pageIndex --;
        }
        if(error == CTNetErrorNet && self.dataSources.count == 0){
            [LMDataResultView showNoNetErrorResultOnView:self.view clickRefreshBlock:^{
                [self request];
            }];
        }
        else{
            [LMDataResultView hideDataResultOnView:self.view];
        }
    }
    if(completed){
        completed();
    }
}

- (void)reloadData{
    if(self.isCollectionView){
        [self.collectionView reloadData];
    }else{
        [self.tableView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

@end
