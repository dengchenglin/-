//
//  CTHandpickDetailViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHandpickDetailViewControllerfj.h"

#import "FJHandpickDescViewfj.h"

#import "CTGoodListCell.h"

#import "CTNetworkEngine+Recommend.h"

@interface FJHandpickDetailViewControllerfj ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) FJHandpickDescViewfj *descView;

@property (nonatomic, strong) CTGoodsViewModel *viewModel;

@end

@implementation FJHandpickDetailViewControllerfj

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 245, 245);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNibWithClass:CTGoodListCell.class];

    }
    return _tableView;
}

- (FJHandpickDescViewfj *)descView{
    if(!_descView){
        _descView = NSMainBundleClass(FJHandpickDescViewfj.class);

    }
    return _descView;
}

- (void)setUpUI{
    self.title = @"官方精选";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.tableView];
}
- (void)autoLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)setUpEvent{
    @weakify(self)
    [self.tableView addHeaderRefreshWithCallBack:^{
        @strongify(self)
        [self request];
    }];
    [self.descView setHeightChangedBlock:^(CGFloat height) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)request{
    self.tableView.hidden = YES;
    [CTRequest fj_officialBuyDetailWithMarkeId:self.Id callback:^(id data, CLRequest *request, CTNetError error) {
        self.tableView.hidden = NO;
        [self.tableView endRefreshing];
        if(!error){
            self.viewModel = [CTGoodsViewModel bindModel:[CTGoodsModel yy_modelWithDictionary:data]];
            self.descView.viewModel = _viewModel;
            [self.tableView reloadData];
        }
    }];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = [self.descView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.descView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.model.goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    cell.model = self.viewModel.model.goods[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] fj_goodDetailViewControllerWithGoodId:self.viewModel.model.goods[indexPath.row].uid];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
