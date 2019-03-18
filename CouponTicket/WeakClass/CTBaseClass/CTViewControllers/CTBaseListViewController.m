//
//  CTBaseListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseListViewController.h"

#import "UIScrollView+CLRefresh.h"

@interface CTBaseListViewController ()

@end

@implementation CTBaseListViewController

- (void)initialize{
    self.pageIndex = 1;
    self.pageSize = 15;
    self.canLoadMore = YES;
    self.dataSources = [NSMutableArray array];
}

- (CTTableView *)tableView{
    if(!_tableView){
        _tableView = [[CTTableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [self.view addSubview:_tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
 
    @weakify(self)
    [NSTimer scheduledTimerWithTimeInterval:0.0001 block:^(NSTimer *timer) {
        @strongify(self)
        [self.tableView addHeaderRefreshWithCallBack:^{
            @strongify(self)
            self.pageIndex = 1;
            self.isLoadMore = NO;
            [self request];
        }];
        if(self.canLoadMore){
            [self.tableView addFooterRefreshWithCallBack:^{
                @strongify(self)
                self.pageIndex += 1;
                self.isLoadMore = YES;
                [self request];
            }];
        }
  
    } repeats:NO];
    
}

- (void)analysisAndReloadWithData:(NSArray *)data error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass{
        [self.tableView endRefreshing];
        if(!error){
            if(!self.isLoadMore){
                [self.dataSources removeAllObjects];
            }
            NSArray *models = [modelClass yy_modelsWithDatas:data];
            for(int i = 0;i < models.count;i ++){
    
                [self.dataSources addObject:[viewModelClass bindModel:models[i]]];
            }
            [self.tableView reloadData];
    
            if(data.count < self.pageSize){
                [self.tableView showNulMoreView];
            }
            else{
                [self.tableView hiddenNulMoreView];
            }
            if(!self.isLoadMore && self.dataSources.count == 0){
                [LMNetErrorView showNoDataResultOnView:self.tableView];
            }
            else{
                [LMNetErrorView hideDataResultOnView:self.tableView];
            }
        }
        else{
            if(self.isLoadMore){
                self.pageIndex --;
            }
            if(error == CTNetErrorNet && self.dataSources.count == 0){
                [LMNetErrorView showNoNetErrorResultOnView:self.view clickRefreshBlock:^{
                    [self request];
                }];
            }
            else{
                [LMNetErrorView hideDataResultOnView:self.view];
            }
        }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

@end
