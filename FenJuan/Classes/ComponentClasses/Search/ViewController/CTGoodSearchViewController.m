
//
//  CTGoodSearchViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodSearchViewController.h"

#import "CTGoodListCell.h"

#import "CTGoodsViewModel.h"

#import "CTNetworkEngine+Goods.h"

#import "CTSearchHotModel.h"

#import "CTGoodSortView.h"

@interface CTGoodSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CTGoodSortView *sortView;

@property (nonatomic, assign) NSUInteger pageIndex;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, copy) NSString *order;

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@end

@implementation CTGoodSearchViewController

- (CTGoodSortView *)sortView{
    if(!_sortView){
        _sortView = [[CTGoodSortView alloc]init];
        _sortView.backgroundColor = [UIColor whiteColor];
    }
    return _sortView;
}

- (NSMutableArray<CTGoodsViewModel *> *)dataSources{
    if(!_dataSources){
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageIndex = 1;
        _pageSize = 30;
    }
    return self;
}

- (void)setUpUI{
    [super setUpUI];
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.dataTableView registerNibWithClass:CTGoodListCell.class];
}

- (void)setUpEvent{
    [super setUpEvent];
    @weakify(self)
    [self.dataTableView addHeaderRefreshWithCallBack:^{
        @strongify(self)
        self.pageIndex = 1;
        self.isLoadMore = NO;
        [self searchKeyword:[self keyword]];
    }];
    [self.dataTableView addFooterRefreshWithCallBack:^{
        @strongify(self)
        self.pageIndex += 1;
        self.isLoadMore = YES;
        [self searchKeyword:[self keyword] order:self.order];
    }];
    
    [self.sortView setClickBlock:^(CTGoodSortType type) {
        @strongify(self)
        self.order = GetGoodsOrderStr(type);
        self.pageIndex = 1;
        self.isLoadMore = NO;
        [self.dataSources removeAllObjects];
        [self.dataTableView reloadData];
        [self searchKeyword:[self keyword] order:self.order];
    }];
}

- (void)request{
    [super request];
    [CTRequest searchHistoryWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
           NSArray *models = [CTSearchHotModel yy_modelsWithDatas:data[@"hot_history"]];
            self.previewView.hotKeywords = [models map:^id(NSInteger index, CTSearchHotModel *element) {
                return element.keyword?:@"";
            }];
        }
    }];
}

- (void)searchKeyword:(NSString *)keyword{
    self.order = nil;
    [self searchKeyword:keyword order:nil];
}
- (void)searchKeyword:(NSString *)keyword order:(NSString *)order{
    [CTRequest goodsSearchWithKeyword:keyword page:self.pageIndex size:self.pageSize order:order callback:^(id data, CLRequest *request, CTNetError error) {
        [self.dataTableView endRefreshing];
        [LMNetErrorView hideDataResultOnView:self.view];
        [LMNetErrorView hideDataResultOnView:self.dataTableView];
        if(!error){
            if(!self.isLoadMore){
                [self.dataSources removeAllObjects];
            }
            NSArray *models = [CTGoodsModel yy_modelsWithDatas:data];
            for(int i = 0;i < models.count;i ++){
                
                [self.dataSources addObject:[CTGoodsViewModel bindModel:models[i]]];
            }
            [self.dataTableView reloadData];
            
            if(models.count < self.pageSize){
                [self.dataTableView showNulMoreView];
            }
            else{
                [self.dataTableView hiddenNulMoreView];
            }
            if(!self.isLoadMore && self.dataSources.count == 0){
                [LMNetErrorView showNoSearchResultOnView:self.dataTableView];
            }

        }
        else{
            if(self.isLoadMore){
                self.pageIndex --;
            }
            if(error == CTNetErrorNet && self.dataSources.count == 0){
                [LMNetErrorView showNoNetErrorResultOnView:self.view clickRefreshBlock:^{
                    [self searchKeyword:keyword order:order];
                }];
            }
        }
    }];
    
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return self.sortView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService]goodDetailViewControllerWithGoodViewModel:self.dataSources[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
