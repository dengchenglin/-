//
//  CTTeamListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTTeamListViewController.h"

#import "CTUserDetailViewController.h"

#import "CTTeamListCell.h"

@interface CTTeamListViewController ()

@end

@implementation CTTeamListViewController

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTTeamListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTTeamListCell.class)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CTUserDetailViewController *vc = [CTUserDetailViewController new];
    vc.userId = nil;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
