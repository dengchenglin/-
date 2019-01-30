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

@interface CTHomeCatoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CTMainCategoryView *categoryView;

@property (nonatomic, strong) CTGoodSortView *sortView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) CTHomeCategoryViewModel *viewModel;

@end

@implementation CTHomeCatoryViewController

@synthesize bounds = _bounds;
@synthesize tableView = _tableView;

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


- (CTTableView *)tableView{
    if(!_tableView){
        _tableView = [[CTTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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

- (UIView *)headView{
    if(!_headView){
        UIView *headView = [UIView new];
        UIView *spaceView = [UIView new];
        spaceView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:spaceView];
        [headView addSubview:self.categoryView];
        [headView addSubview:self.sortView];
        [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
        [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(spaceView.mas_bottom);
            make.left.right.mas_equalTo(0);
        }];
        [self.sortView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.categoryView.mas_bottom).offset(10);
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _headView = headView;
    }
    return _headView;
}

- (CTHomeCategoryViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTHomeCategoryViewModel new];
    }
    return _viewModel;
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
    [self.categoryView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService]goodListViewControllerWithCategoryId:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)request{
    [self reloadData:nil];
}

- (void)reloadData:(id)data{
     NSArray <CTCategoryModel *>*models = [CTCategoryModel yy_modelsWithDatas:[self testCategory]];
    self.viewModel.subCategoryModels = models;
    [self.tableView reloadData];

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    self.categoryView.categoryModels = self.viewModel.subCategoryModels;
    CGFloat height = [self.headView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return self.headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService]goodDetailViewControllerWithGoodId:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSArray *)testCategory{
    
    return @[@{@"title":@"今日精选"},@{@"title":@"女装"},@{@"title":@"母婴儿童"},@{@"title":@"内衣"},@{@"title":@"居家"},@{@"title":@"男装"},@{@"title":@"女装"},@{@"title":@"内裤"}];
}
@end
