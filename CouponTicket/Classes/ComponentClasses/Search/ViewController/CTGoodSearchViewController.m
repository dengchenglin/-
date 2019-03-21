
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

@interface CTGoodSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSUInteger pageIndex;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@end

@implementation CTGoodSearchViewController

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
        _pageSize = 15;
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
        [self searchKeyword:[self keyword]];
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
    [CTRequest goodsSearchWithKeyword:keyword page:self.pageIndex size:self.pageSize order:nil callback:^(id data, CLRequest *request, CTNetError error) {
        [self.dataTableView endRefreshing];
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
                [LMNetErrorView showNoDataResultOnView:self.dataTableView];
            }
            else{
                [LMNetErrorView hideDataResultOnView:self.dataTableView];
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
    }];
    
}
#pragma mark - UITableViewDelegate

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
