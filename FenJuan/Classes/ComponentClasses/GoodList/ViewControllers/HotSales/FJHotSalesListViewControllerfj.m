//
//  CThotSalesListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHotSalesListViewControllerfj.h"

#import "FJHotSalesNoticeViewfj.h"

#import "CTGoodListCell.h"

#import "CTNetworkEngine+Index.h"

#import "FJHotGoodsModelfj.h"

@interface FJHotSalesListViewControllerfj ()

@property (nonatomic, strong) FJHotSalesNoticeViewfj *noticeView;

@property (nonatomic, strong) FJHotGoodsModelfj *model;

@property (nonatomic, copy) NSArray <CTGoodsViewModel *> *dataSources;

@end

@implementation FJHotSalesListViewControllerfj
@synthesize dataSources = _dataSources;
- (FJHotSalesNoticeViewfj *)noticeView{
    if(!_noticeView){
        _noticeView = NSMainBundleClass(FJHotSalesNoticeViewfj.class);
    }
    return _noticeView;
}

- (void)setUpUI{
    self.title = @"实时热销榜";
    self.canLoadMore = NO;
    [self.view addSubview:self.noticeView];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNibWithClass:CTGoodListCell.class];
}

- (void)autoLayout{
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noticeView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}
- (void)request{
    [CTRequest hotGoodsWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.tableView endRefreshing];
        if(!error){
            self.model = [FJHotGoodsModelfj yy_modelWithDictionary:data];
            self.noticeView.model = _model;
            self.dataSources = [CTGoodsViewModel bindModels:[CTGoodsModel yy_modelsWithDatas:_model.goods]];
            [self.tableView reloadData];
        }
    }];
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
