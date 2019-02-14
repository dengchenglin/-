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
    self.dataSoures = [NSMutableArray array];
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
        [self.tableView addFooterRefreshWithCallBack:^{
            @strongify(self)
            self.pageIndex += 1;
            self.isLoadMore = YES;
            [self request];
        }];
    } repeats:NO];
    
}

//- (void)analysisAndReloadWithData:(id)data listKey:(NSString *)listKey error:(LMNetError)error modelClass:(Class)modelClass viewModelClass:(Class <LMViewModelProtocol>)viewModelClass{
//    [self.tableView endRefreshing];
//    if(!error){
//        if(!self.isLoadMore){
//            [self.dataSoures removeAllObjects];
//        }
//        NSArray *models = [modelClass yy_modelsWithDatas:data[listKey]];
//        for(int i = 0;i < models.count;i ++){
//            
//            [self.dataSoures addObject:[viewModelClass bindModel:models[i]]];
//        }
//        [self.tableView reloadData];
//        
//        NSInteger total = [data[@"total"] integerValue];
//        if(self.dataSoures.count >= total){
//            [self.tableView showNulMoreView];
//        }
//        else{
//            [self.tableView hiddenNulMoreView];
//        }
//        if(!self.isLoadMore && self.dataSoures.count == 0){
//            [LMNetErrorView showNoDataResultOnView:self.tableView];
//        }
//        else{
//            [LMNetErrorView hideDataResultOnView:self.tableView];
//        }
//    }
//    else{
//        if(self.isLoadMore){
//            self.pageIndex --;
//        }
//        if(error == LMNetErrorNet && self.dataSoures.count == 0){
//            [LMNetErrorView showNoNetErrorResultOnView:self.view clickRefreshBlock:^{
//                [self request];
//            }];
//        }
//        else{
//            [LMNetErrorView hideDataResultOnView:self.view];
//        }
//    }
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

@end
