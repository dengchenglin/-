//
//  CTHomeCatoryViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeCatoryViewController.h"

#import "CTMainCategoryView.h"

#import "CTHomeCategoryViewModel.h"

#import "CTGoodListCell.h"

#import "CTGoodSortView.h"

#import "CTNetworkEngine+Index.h"

@interface CTHomeCatoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CTTableView *tableView;


@property (nonatomic, strong) CTMainCategoryView *categoryView;

@property (nonatomic, strong) CTGoodSortView *sortView;

@property (nonatomic, strong) CTHomeCategoryViewModel *viewModel;

@property (nonatomic, assign) NSUInteger pageIndex;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, copy) NSArray <CTCategoryModel *>*subCategoryModels;

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@end

@implementation CTHomeCatoryViewController

@synthesize bounds = _bounds;

- (CTMainCategoryView *)categoryView{
    if(!_categoryView){
        _categoryView = [[CTMainCategoryView alloc]init];
        
    }
    return _categoryView;
}

- (CTGoodSortView *)sortView{
    if(!_sortView){
        _sortView = [[CTGoodSortView alloc]init];
        _sortView.backgroundColor = [UIColor whiteColor];
    }
    return _sortView;
}

- (CTHomeCategoryViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTHomeCategoryViewModel new];
    }
    return _viewModel;
}


- (CTTableView *)tableView{
    if(!_tableView){
        _tableView = [[CTTableView alloc]initWithFrame:CGRectZero];
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
    self.hideSystemNavBarWhenAppear = YES;
    self.tableView.backgroundColor = RGBColor(245, 245, 245);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNibWithClass:CTGoodListCell.class];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setUpEvent{
    @weakify(self)
    [self.tableView addHeaderRefreshWithCallBack:^{
        @strongify(self)
        self.pageIndex = 1;
        self.isLoadMore = NO;
        [self request];
    }];
    [self.tableView addFooterRefreshWithCallBack:^{
        @strongify(self)
        self.pageIndex ++;
        self.isLoadMore = YES;
        [self request];
    }];
    [self.categoryView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService]goodListViewControllerWithCategoryId:self.subCategoryModels[index].uid];
        vc.title = self.subCategoryModels[index].title;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.sortView setClickBlock:^(CTGoodSortType type) {
        @strongify(self)
        self.viewModel.sortType = type;
        self.pageIndex = 1;
        self.isLoadMore = NO;
        [self.dataSources removeAllObjects];
        [self.tableView reloadData];
        [self loadlListData];
    }];
}

- (void)request{
    //加载子分类
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [CTRequest cateWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [LMNoDataView hideDataResultOnView:self.view];
        [self.tableView endRefreshing];
        if(!error){
            NSArray <CTCategoryModel *>*models = [CTCategoryModel yy_modelsWithDatas:data];
            self.subCategoryModels = models;
            self.categoryView.categoryModels = self.subCategoryModels;
            [self.tableView reloadData];
        }
        else if (!self.subCategoryModels.count && !self.dataSources.count){
            [LMNoDataView showNoNetErrorResultOnView:self.view clickRefreshBlock:^{
                [self request];
            }];
        }
    }];
    [self loadlListData];
  
}
- (void)loadlListData{
    //加载商品列表
    [CTRequest cateGoodsWithPage:self.pageIndex size:self.pageSize cateId:self.cateId order:self.viewModel.order showHud:NO callback:^(NSArray *data, CLRequest *request, CTNetError error) {
        if(!error){
            if(!self.isLoadMore){
                [self.dataSources removeAllObjects];
            }
            for(int i = 0;i < data.count;i ++){
                [self.dataSources addObject:[CTGoodsViewModel bindModel:[CTGoodsModel yy_modelWithDictionary:data[i]]]];
            }
            [self.tableView reloadData];
            if(data.count < self.pageSize){
                [self.tableView showNulMoreView];
            }
            else{
                [self.tableView hiddenNulMoreView];
            }
        }
        else if(self.isLoadMore){
            self.pageIndex --;
        }
    }];
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        CGFloat height =  [self.categoryView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
        return height;
    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return self.categoryView;
    }
    return self.sortView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0 && self.subCategoryModels.count){
        return 10;
    }
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 0;
    }
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return nil;
    }
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService]goodDetailViewControllerWithGoodId:self.dataSources[indexPath.row].model.uid];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
