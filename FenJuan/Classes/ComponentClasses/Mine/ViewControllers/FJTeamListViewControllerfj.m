//
//  CTTeamListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJTeamListViewControllerfj.h"

#import "CTUserDetailViewController.h"

#import "CTTeamListCell.h"

#import "CTNetworkEngine+Member.h"

#import "FJRecListViewControllerfj.h"

@interface FJTeamListViewControllerfj ()<CTTeamListCellDelegate>

@property (nonatomic, strong) NSMutableArray <CTUser *> *dataSources;

@end

@implementation FJTeamListViewControllerfj

@synthesize dataSources = _dataSources;

- (void)setUpUI{
    self.title = @"我的团队";
    self.hideNavBarBottomLine = YES;
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.tableView registerNibWithClass:CTTeamListCell.class];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)autoLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest fj_teamListWithCateId:self.cateId page:self.pageIndex size:self.pageSize callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTUser.class viewModelClass:nil];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTTeamListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTTeamListCell.class)];
    cell.user = self.dataSources[indexPath.row];
    cell.delegate = self;
    cell.index = indexPath.row;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager userInfoService]viewControllerForUserId:  self.dataSources[indexPath.row].uid];
    [self.navigationController pushViewController:vc animated:YES];
  
}

- (void)didClickRecWithIndex:(NSInteger)index{
    FJRecListViewControllerfj *vc = [FJRecListViewControllerfj new];
    vc.userId = self.dataSources[index].uid;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
