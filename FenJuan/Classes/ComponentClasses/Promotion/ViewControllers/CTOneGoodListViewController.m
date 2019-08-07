//
//  CTOneGoodListViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTOneGoodListViewController.h"

#import "CTOneGoodIndexCell.h"

#import "CTNetworkEngine+ProGood.h"

@interface CTOneGoodListViewController ()<CTOneGoodIndexCellDelegate>

@property (nonatomic, strong) NSMutableArray <CTProGoodIndexViewModel *> *dataSources;

@end

@implementation CTOneGoodListViewController

@synthesize dataSources = _dataSources;

- (void)setUpUI{
    self.pageSize = 5;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNibWithClass:CTOneGoodIndexCell.class];
}

- (void)autoLayout{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest fqGoodsWithMinId:self.minId callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data listKey:@"list" error:error modelClass:CTGoodsModel.class viewModelClass:CTProGoodIndexViewModel.class];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSources[indexPath.row].onGoodCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTOneGoodIndexCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTOneGoodIndexCell.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    cell.index = indexPath.row;
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] goodDetailViewControllerWithGoodId:self.dataSources[indexPath.row].model.item_id];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CTOneGoodIndexCellDelegate
- (void)didShareWithIndex:(NSInteger)index{
    CTGoodsModel *model = self.dataSources[index].model;
    CTGoodsViewModel *viewModel = [CTGoodsViewModel bindModel:model];
    [CTModuleHelper shareShopFromViewController:self viewModel:viewModel];
}
@end
