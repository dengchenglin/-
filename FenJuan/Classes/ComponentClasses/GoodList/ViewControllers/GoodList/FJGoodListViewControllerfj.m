//
//  CTGoodListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJGoodListViewControllerfj.h"

#import "CTGoodSortView.h"

#import "CTGoodListCell.h"

#import "CTNetworkEngine+Index.h"

@interface FJGoodListViewControllerfj ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CTGoodSortView *sortView;

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@end

@implementation FJGoodListViewControllerfj

@synthesize dataSources = _dataSources;

- (CTGoodSortView *)sortView{
    if(!_sortView){
        _sortView = [[CTGoodSortView alloc]init];
        _sortView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"p_nav_bg"]];
        _sortView.normalColor = [UIColor whiteColor];
        _sortView.selectedColor = [UIColor whiteColor];
        _sortView.upDownNormalColor = [UIColor whiteColor];
        _sortView.upDownSelectedColor = [UIColor whiteColor];
        _sortView.showSilder = YES;
    }
    return _sortView;
}

- (void)setUpUI{
    [self.view addSubview:self.sortView];
    [self.view addSubview:self.tableView];
    [self.tableView registerNibWithClass:CTGoodListCell.class];
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
        [self.dataSources removeAllObjects];
        [self.tableView reloadData];
        self.pageIndex = 1;
        self.isLoadMore = NO;
        [self request];
    }];
}

- (void)request{
    if(self.category_id){
        [CTRequest fj_cateGoodsWithPage:self.pageIndex size:self.pageSize cateId:self.category_id order:GetGoodsOrderStr(self.sortView.currentType) callback:^(id data, CLRequest *request, CTNetError error) {
            [self analysisAndReloadWithData:data error:error modelClass:CTGoodsModel.class viewModelClass:CTGoodsViewModel.class];
        }];
    }
    else if (self.activity_id){
        [CTRequest activityGoodsWithPage:self.pageIndex size:self.pageSize activityId:self.activity_id order:GetGoodsOrderStr(self.sortView.currentType) callback:^(id data, CLRequest *request, CTNetError error) {
            [self analysisAndReloadWithData:data error:error modelClass:CTGoodsModel.class viewModelClass:CTGoodsViewModel.class];
        }];
    }
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
    UIViewController *vc = [[CTModuleManager goodListService] fj_goodDetailViewControllerWithGoodId:self.dataSources[indexPath.row].model.uid];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
